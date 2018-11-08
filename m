Return-Path: <keith.busch@intel.com>
Date: Wed, 7 Nov 2018 18:22:52 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
Message-ID: <20181108012251.GB15857@localhost.localdomain>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
 <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
 <20181107160909.GC11941@localhost.localdomain>
 <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08, 2018 at 09:12:59AM +0800, Ming Lei wrote:
> Is it NVMe specific issue or common problem in other storage hardware?  SCSI
> does call blk_update_request() and handles partial completion.

Not specific to NVMe.

An example using SG_IO dumping 2MB of unsanitized kernel memory:

sg-test.c:
---
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <scsi/sg.h>
#include <scsi/scsi.h>

#define SIZE (2 * 1024 * 1024 + 8)
int main(int argc, char **argv)
{
	struct sg_io_hdr io_hdr;
	unsigned char *buffer, cmd[6] = { TEST_UNIT_READY };
	int sg, i;

	if (argc < 2)
		fprintf(stderr, "usage: %s <sgdev>\n", argv[0]), exit(0);

	sg = open(argv[1], O_RDONLY);
	if (sg < 0)
		perror("open"), exit(0);

	buffer = malloc(SIZE);
	if (!buffer)
		fprintf(stderr, "no memory\n"), exit(0);

	memset(&io_hdr, 0, sizeof(struct sg_io_hdr));
	io_hdr.interface_id = 'S';
	io_hdr.cmd_len = 6;
	io_hdr.cmdp = cmd;
	io_hdr.dxfer_direction = SG_DXFER_FROM_DEV;
	io_hdr.dxfer_len = SIZE;
	io_hdr.dxferp = buffer;

	memset(buffer, 0, SIZE);
	ioctl(sg, SG_IO, &io_hdr);
	for (i = 0; i < SIZE; i++) {
		printf("%02x", buffer[i]);
		if (i+1 % 32 == 0)
			printf("\n");
	}
}
--

Test on qemu:
---
$ ./sg-test /dev/sda | grep -v 000000000000000000000000000000000
40733f4019dbffff8001244019dbffff4065244019dbffff0094244019dbffff
c025244019dbffffc0e43a4019dbffff40973a4019dbffffc0623a4019dbffff
800c244019dbffffc0d61d4019dbffffc05f244019dbffff80091e4019dbffff
40913a4019dbffff806f3f4019dbffff40a83f4019dbffffc083244019dbffff
80eb1e4019dbffff00a93f4019dbffffc09a3a4019dbffff40503f4019dbffff
007f1b4019dbffffc0d91e4019dbffff40551e4019dbffff804a1b4019dbffff
....
--

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36625 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJWHN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 03:13:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so19733462plt.3
        for <linux-block@vger.kernel.org>; Mon, 22 Oct 2018 15:52:58 -0700 (PDT)
Date: Mon, 22 Oct 2018 15:52:55 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/2] loop/006: Add test for setting partscan flag
Message-ID: <20181022225255.GB10074@vader>
References: <20181018103147.3567-1-jack@suse.cz>
 <20181018103147.3567-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018103147.3567-2-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 18, 2018 at 12:31:46PM +0200, Jan Kara wrote:
> Add test for setting partscan flag.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Sorry I didn't notice this earlier, but loop/001 already does a
partition rescan (via losetup -P). Does that cover this test case?

> ---
>  src/Makefile                   |  3 ++-
>  src/loop_set_status_partscan.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/006                 | 33 +++++++++++++++++++++++++++++++
>  tests/loop/006.out             |  2 ++
>  4 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 src/loop_set_status_partscan.c
>  create mode 100755 tests/loop/006
>  create mode 100644 tests/loop/006.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index f89f61701179..6dadcbec8beb 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -4,7 +4,8 @@ C_TARGETS := \
>  	openclose \
>  	sg/dxfer-from-dev \
>  	sg/syzkaller1 \
> -	nbdsetsize
> +	nbdsetsize \
> +	loop_set_status_partscan
>  
>  CXX_TARGETS := \
>  	discontiguous-io
> diff --git a/src/loop_set_status_partscan.c b/src/loop_set_status_partscan.c
> new file mode 100644
> index 000000000000..8873a12e4334
> --- /dev/null
> +++ b/src/loop_set_status_partscan.c
> @@ -0,0 +1,45 @@
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <linux/loop.h>
> +
> +void usage(const char *progname)
> +{
> +	fprintf(stderr, "usage: %s PATH\n", progname);
> +	exit(EXIT_FAILURE);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret;
> +	int fd;
> +	struct loop_info64 info;
> +
> +	if (argc != 2)
> +		usage(argv[0]);
> +
> +	fd = open(argv[1], O_RDONLY);
> +	if (fd == -1) {
> +		perror("open");
> +		return EXIT_FAILURE;
> +	}
> +
> +	memset(&info, 0, sizeof(info));
> +	info.lo_flags = LO_FLAGS_PARTSCAN;
> +	memcpy(info.lo_file_name, "part", 5);

What's the significance of this file name?

> +	ret = ioctl(fd, LOOP_SET_STATUS64, &info);
> +	if (ret == -1) {
> +		perror("ioctl");
> +		close(fd);
> +		return EXIT_FAILURE;
> +	}
> +	close(fd);
> +	return EXIT_SUCCESS;
> +}

[snip]

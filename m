Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] block: allow WRITE_SAME commands with the SG_IO
 ioctl
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linux-block@vger.kernel.org
References: <1481824098-5555-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Cc: hch@infradead.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, latha@linux.vnet.ibm.com,
 manjuhr1@in.ibm.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b62fd71d-0831-c402-1d09-c78779dee060@kernel.dk>
Date: Mon, 19 Dec 2016 08:34:33 -0700
MIME-Version: 1.0
In-Reply-To: <1481824098-5555-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/15/2016 10:48 AM, Mauricio Faria de Oliveira wrote:
> The WRITE_SAME commands are not present in the blk_default_cmd_filter
> write_ok list, and thus are failed with -EPERM when the SG_IO ioctl()
> is executed without CAP_SYS_RAWIO capability (e.g., unprivileged users).
> [ sg_io() -> blk_fill_sghdr_rq() > blk_verify_command() -> -EPERM ]

Added for 4.10, thanks.

-- 
Jens Axboe

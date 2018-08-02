Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <50e0f257-60d9-73c8-b4ac-a93c7bdccb57@kernel.dk>
References: <20180731195155.46664-1-keescook@chromium.org> <50e0f257-60d9-73c8-b4ac-a93c7bdccb57@kernel.dk>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 2 Aug 2018 14:56:49 -0700
Message-ID: <CAGXu5jLKk_9rw5etROW4ucwK+ZR7YfC_zq+6AwtxK4=S3Y7sOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] block: Consolidate scsi sense buffer usage
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>, "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
	"Nicholas A. Bellinger" <nab@linux-iscsi.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Stephen Boyd <sboyd@codeaurora.org>,
	Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Juergen Gross <jgross@suse.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sagar Dharia <sdharia@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vinod.koul@intel.com>, David Kershner <david.kershner@unisys.com>,
	linux-block <linux-block@vger.kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, target-devel <target-devel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 2, 2018 at 2:24 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/31/18 1:51 PM, Kees Cook wrote:
>> This is a follow-up to commit f7068114d45e ("sr: pass down correctly
>> sized SCSI sense buffer") which further cleans up and removes needless
>> sense character array buffers and "struct request_sense" usage in favor
>> of the common "struct scsi_sense_hdr".
>>
>> First, drop a bunch of unused sense buffers:
>>  [PATCH 1/9] ide-cd: Drop unused sense buffers
>>  [PATCH 2/9] scsi: cxlflash: Drop unused sense buffers
>>
>> Next, allow the sense buffer to be usable outside SCSI tree:
>>  [PATCH 3/9] scsi: build scsi_common.o for all scsi passthrough request users
>>  [PATCH 4/9] target: don't depend on SCSI
>>
>> Then move all request_sense usage to scsi_sense_hdr:
>>  [PATCH 5/9] block: Switch struct packet_command to use struct scsi_sense_hdr
>>
>> And do some further cleanups for scsi_sense_hdr now that we can:
>>  [PATCH 6/9] ide-cd: Remove redundant sense buffer
>>  [PATCH 7/9] cdrom: Use struct scsi_sense_hdr internally
>>
>> Finally add a build-time check to make sure we don't pass bad buffer sizes:
>>  [PATCH 8/9] libata-scsi: Move sense buffers onto stack
>>  [PATCH 9/9] scsi: Check sense buffer size at build time
>
> Thanks Kees, applied for 4.19. Note that I hand applied patch #5 and #9,
> since they did not apply directly to the block tree.

Thanks; I appreciate that. I think I was based on v4.18-rc2 or something.

-Kees

-- 
Kees Cook
Pixel Security

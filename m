Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <8faec18239a6104b250d9668bb1d3abc@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
 <2864697.7uzmEJovl2@natalenko.name> <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com> <8faec18239a6104b250d9668bb1d3abc@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Apr 2018 09:25:15 -0700
Message-ID: <CAGXu5jLcrymg8bDXB=MRKwwAqN2Y=qMeO4PNDQ_t4DekyOk+JQ@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Paolo Valente <paolo.valente@linaro.org>, David Windsor <dave@nullcore.net>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17, 2018 at 2:19 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> By any chance, have you tried to simplify the reproducer environment, or it
> still needs my complex layout to trigger things even with KASAN?

I haven't tried minimizing the reproducer yet, no. Now that I have a
specific place to watch in the kernel for the corruption, though, that
might help. If I get stuck again today, I'll try it.

-Kees

-- 
Kees Cook
Pixel Security

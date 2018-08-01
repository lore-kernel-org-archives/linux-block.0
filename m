Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <6c04fc087bae896bf00b94184def3d7697a22d6c.camel@wdc.com>
References: <20180731195155.46664-1-keescook@chromium.org> <20180731195155.46664-4-keescook@chromium.org>
 <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com> <20180731201225.GA1989@infradead.org>
 <6c04fc087bae896bf00b94184def3d7697a22d6c.camel@wdc.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 1 Aug 2018 12:50:26 -0700
Message-ID: <CAGXu5jK2kLiOGTbq2TCBp97c2KZsZKPDNLSWDWY4r+RQpAP4fQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi passthrough
 request users
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"david.kershner@unisys.com" <david.kershner@unisys.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"nab@linux-iscsi.org" <nab@linux-iscsi.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"jgross@suse.com" <jgross@suse.com>,
	"cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
	"sdharia@codeaurora.org" <sdharia@codeaurora.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"pombredanne@nexb.com" <pombredanne@nexb.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>, "tj@kernel.org" <tj@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 1:18 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Tue, 2018-07-31 at 13:12 -0700, hch@infradead.org wrote:
>> It shouldn't.  All these are built into scsi_mod.o, which is only built
>> when CONFIG_SCSI is set.  Under what circumstances do you see them built?
>
> Although I think you are right, I still prefer that the scsi_common.c file
> would be moved to a new directory. That will prevent confusion later on for
> people who want to add additional code. This patch makes it nontrivial to
> figure out which code is built when SCSI target functionality is enabled but
> SCSI initiator functionality is not selected. I think moving scsi_common.c
> into a new directory would make it much easier to figure out which code is
> built depending on the kernel configuration.

While I don't disagree with you, this series is the result of several
back-and-forth discussions where that option was seemingly rejected.
Christoph's approach seemed to satisfy Jens. If you can convince them,
sure! I'll do whatever the consensus is. :)

-Kees

-- 
Kees Cook
Pixel Security

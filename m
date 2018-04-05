Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Apr 2018 07:42:03 -0700
From: Tejun Heo <tj@kernel.org>
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [BISECTED][REGRESSION] Hang while booting EeePC 900
Message-ID: <20180405144203.GC3126663@devbig577.frc2.facebook.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
 <de102067-b589-af05-ae71-496e948000f0@kernel.dk>
 <CALjAwxgtuEv=d1TfvH3EdXqZs=_6F7TinyVhbPdUmTsdK_5ghw@mail.gmail.com>
 <20180402202951.GE388343@devbig577.frc2.facebook.com>
 <CALjAwxhofAEa1Nr8d1+KpB3jimYL9nODf4Fu38oTe7ptgM_+cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjAwxhofAEa1Nr8d1+KpB3jimYL9nODf4Fu38oTe7ptgM_+cQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 05, 2018 at 09:14:15AM +0100, Sitsofe Wheeler wrote:
> Just out of interest, does the fact that an abort occurs mean that the
> hardware is somehow broken or badly behaved?

Not really.  For example, ATAPI devices depend on exception handling
to fetch sense data as a part of normal operation which is handled by
libata exception handler which is invoked by aborting the original
command.  So, exception handling can often be a part of normal
operation.

Thanks.

-- 
tejun

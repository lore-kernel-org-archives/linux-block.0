Return-Path: <markus@trippelsdorf.de>
Date: Tue, 2 May 2017 10:00:44 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Subject: Re: Playing with BFQ
Message-ID: <20170502080044.GA292@x4>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
> Hi,
> 
> I want to play with BFQ.
> 
> My base is block-next as of 28-Apr-2017.
> 
> First I looked through the Kconfigs.
> What is a good setting?
> Built as module?
> 
> How can I switch the IO-scheduler - real-time?
> 
> Not sure if the attached patches make sense (right now).

No, it doesn't make sense at all.
BFQ is a mq scheduler. To use it you should enable
SCSI_MQ_DEFAULT. And then you can switch schedulers like:

 echo "kyber" > /sys/block/sda/queue/scheduler
 echo "bfq" > /sys/block/sdb/queue/scheduler

-- 
Markus

Return-Path: <xjtuwjp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
References: <CADL4p-rRJ6ydSuYBsjUOOE88ZUF5g_akY5Eb-bnA4ZsodhLEDQ@mail.gmail.com>
 <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
From: Jack Wang <xjtuwjp@gmail.com>
Date: Thu, 9 Nov 2017 17:09:01 +0100
Message-ID: <CAD+HZHVtXozfiQ2_gs4b5XHLveye+YUwkBMFNi7nWeLui9J2-A@mail.gmail.com>
Subject: Re: kernel 4.14 how to install Mellanox connectx-3 infiniband driver?
To: Tony Yang <yyt168@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Tony,

2017-11-09 16:20 GMT+01:00 Tony Yang <yyt168@gmail.com>:
> Hi, All
>    I downloaded the nvme with multipath kernel, The kernel version is
> 4.14, I encountered a problem, I use Mellanox connectx-3 infiniband
> driver. Because the 4.14 kernel version is too new to install
> infiniband driver, does anyone encounter with me The same situation?
> How to solve? Thank you for your help.
>
As Sagi also said, there is driver in tree.

You need build you kernel with CONFIG_MLX4_INFINIBAND enabled.

Jack
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

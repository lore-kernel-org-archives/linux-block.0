Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <BY2PR0401MB0901B37DB60608662AE5C631E5050@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
 <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
 <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
 <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com> <BY2PR0401MB0901B37DB60608662AE5C631E5050@BY2PR0401MB0901.namprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 15 Apr 2017 20:34:48 +0200
Message-ID: <CACRpkdbstMEC-_JcEfEm1debQRPeYBDmTPm0L_jGFnrgRZg1Zw@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 14, 2017 at 8:41 PM, Avri Altman <Avri.Altman@sandisk.com> wrote:
> [Me]
>> 2. Turn RPMB and other ioctl() MMC operations into mmc_queue_req
>>    things and funnel them into the block scheduler
>>    using REQ_OP_DRV_IN/OUT requests.
>>
>
> Accessing the RPMB is done via a strange protocol, in which each access is comprised of several requests.
> For example, writing to the RPMB will require sending 5 different requests:
> 2 requests to read the write counter, and then 3 more requests for the write operation itself.
>
> Once the sequence has started, it should not get interfered by other requests, or the operation will fail.

So I guess currently something takes a host lock and then performs the
5 requests.

Thus we need to send a single custom request containing a list of 5
things to do, and return after that.

Or do you mean that we return to userspace inbetween these different
requests and the sequencing is done in userspace?

I hope not because that sounds fragile, like userspace could crash and
leave the host lock dangling :/

Yours,
Linus Walleij

Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f9e25794-7619-bc61-7e90-f09e73853deb@intel.com>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
 <0ab6b0b7-74e7-f7d3-9137-baf259282914@intel.com> <CACRpkdb_ZN+3YKYJ2L-5JNt1SgUqyCS3G-HER4e+LRcV64Jfag@mail.gmail.com>
 <363DA0ED52042842948283D2FC38E4649BF396BD@IRSMSX106.ger.corp.intel.com>
 <CACRpkdb795LnNkpo=Jg_fnn1mJwnE0A+FXwj5NjcUqCDhp32Ww@mail.gmail.com> <f9e25794-7619-bc61-7e90-f09e73853deb@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Oct 2017 16:29:05 +0200
Message-ID: <CACRpkdYT6SJeECBp-KJtbqsjV9yYNW5oyxB2j-Zc_MAMEJaiAw@mail.gmail.com>
Subject: Re: [PATCH 00/12 v4] multiqueue for MMC/SD
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 27, 2017 at 2:59 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 27/10/17 14:25, Linus Walleij wrote:

>> It is indeed tough to juggle this with the pressure to "upstream
>> first" the BFQ scheduler policy that we are working on in Linaro
>> to increase interactivity. We need to enable this on devices
>> pronto and that means migrating MMC/SD to MQ and MQ only.
>> I have shared this motivation since the start, so it should come
>> as no surprise.
>
> IMHO BFQ is just another example of unnecessary delay.

I do not see it as a delay to anything, it is a motivation for
my work. I am telling you why I am still working on my patch
set, what is driving and motivating it.

I guess CQE is driving and motivating your work?

>> So I also have some pressure to "Get This Feature In Now".
>
> It has nothing to do with pressure.  It is about what is reasonable.
> Features should go in as soon as they are ready.  Ideally queued up in the
> same release cycle they are submitted.  If the code doesn't work right, then
> it can't go in straight away, but fake reasons for delaying things needs to
> stop.

I don't understand who you are addressing or accusing.

Nobody wants to delay CQE if that is what you are implying,
I want to see it supported as much as you do.

I just prefer to see MQ happen first, and now you say your patch
set does that and that is great, so I just need to review the code
better I guess?

Yours,
Linus Walleij

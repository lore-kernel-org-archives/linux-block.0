Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1483358104.3592.50.camel@sandisk.com>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org> <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
 <20161228085503.GA340@lst.de> <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
 <1483358104.3592.50.camel@sandisk.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 3 Jan 2017 13:59:11 +0100
Message-ID: <CACRpkdbB-4hKNoaANwFmcgPwDNaPdYmMmuEpuj19FXXECMq0VA@mail.gmail.com>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"baolin.wang@linaro.org" <baolin.wang@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"riteshh@codeaurora.org" <riteshh@codeaurora.org>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"zhang.chunyan@linaro.org" <zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 2, 2017 at 12:55 PM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Thu, 2016-12-29 at 00:59 +0100, Linus Walleij wrote:
>> A problem here is that issueing the requests are in blocking context
>> while completion is in IRQ context (for most drivers) so we need to
>> look into this.
>
> Hello Linus,
>
> Although I'm not sure whether I understood you correctly: are you familiar
> with the request queue flag BLK_MQ_F_BLOCKING, a flag that was introduced
> for the nbd driver?

BLK_MQ_F_BLOCKING is what the patch set is currently using...

The problem I have is that request need to be *issued* in blocking
context and *completed* in fastpath/IRQ context.

Yours,
Linus Walleij

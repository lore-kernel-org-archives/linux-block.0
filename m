Return-Path: <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1510332224.2905.4.camel@wdc.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
 <20171103222339.26540-3-bart.vanassche@wdc.com> <1510332224.2905.4.camel@wdc.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 10 Nov 2017 20:19:58 +0000
Message-ID: <CAKv+Gu--2wdT5p1HcsxyP0Jo5e+zm03uoUChobrfc_zcwJjqFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 10 November 2017 at 16:43, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Fri, 2017-11-03 at 15:23 -0700, Bart Van Assche wrote:
>> Use the sgl_alloc() and sgl_free() functions instead of open coding
>> these functions.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>
> Hello Ard and Herbert,
>
> Would it be possible for one of you to share your opinion about this patch?
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

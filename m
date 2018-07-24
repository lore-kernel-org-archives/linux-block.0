Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-18-keescook@chromium.org>
 <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Jul 2018 10:51:27 -0700
Message-ID: <CAGXu5j+-AwHdGZ7Be854WyEQoK2p57JPuTgSXcFq7GOzUtJGEA@mail.gmail.com>
Subject: Re: [PATCH v6 17/18] crypto: ccm: Remove VLA usage
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@google.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alasdair Kergon <agk@redhat.com>, Rabin Vincent <rabinv@axis.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Mike Snitzer <snitzer@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Will Deacon <will.deacon@arm.com>, device-mapper development <dm-devel@redhat.com>,
	linux-pm <linux-pm@vger.kernel.org>,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, drbd-dev@lists.linbit.com,
	linux-block <linux-block@vger.kernel.org>, qat-linux@intel.com,
	linux-ppp@vger.kernel.org,
	"<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, linux-afs@lists.infradead.org,
	"<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 24, 2018 at 9:57 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 24 July 2018 at 18:49, Kees Cook <keescook@chromium.org> wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
>> with the skcipher area (which are not used at the same time).
>>
>
> -EGRAMMAR

Whoops. Will fix my poor sentence merging. :)

-Kees

-- 
Kees Cook
Pixel Security

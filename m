Return-Path: <markus@trippelsdorf.de>
Date: Tue, 2 May 2017 14:16:05 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Subject: Re: Playing with BFQ
Message-ID: <20170502121605.GA294@x4>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4>
 <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> > On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
> >> Hi,
> >>
> >> I want to play with BFQ.
> >>
> >> My base is block-next as of 28-Apr-2017.
> [...]
> >> Not sure if the attached patches make sense (right now).
> >
> > No, it doesn't make sense at all.
> 
> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).

BFQ started as a conventional scheduler. But because mq is the way of
the future it was ported before it was accepted into mainline.

-- 
Markus

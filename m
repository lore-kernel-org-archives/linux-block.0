Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"samuele.zecchini92@gmail.com" <samuele.zecchini92@gmail.com>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "avanzini.arianna@gmail.com"
	<avanzini.arianna@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"riccardo.pizzetti@gmail.com" <riccardo.pizzetti@gmail.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/16] block, bfq: reduce idling only in symmetric
 scenarios
Date: Fri, 31 Mar 2017 15:20:29 +0000
Message-ID: <1490973609.2587.3.camel@sandisk.com>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
	 <20170331124743.3530-12-paolo.valente@linaro.org>
In-Reply-To: <20170331124743.3530-12-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
> +=A0=A0=A0=A0=A0=A0=A0entity->weight_counter =3D kzalloc(sizeof(struct bf=
q_weight_counter),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GFP_ATOMIC);
> +=A0=A0=A0=A0=A0=A0=A0entity->weight_counter->weight =3D entity->weight;

GFP_ATOMIC allocations are more likely to fail than GFP_KERNEL allocations.
What will happen if kzalloc() returns NULL?

Bart.=

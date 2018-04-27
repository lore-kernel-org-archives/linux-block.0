Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
 <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
 <110372C3-6206-45FC-9610-614790144564@linaro.org>
 <cb9cc55a-8696-98b1-143a-4ee66630c483@kernel.dk>
 <078F88D3-B9E3-415F-BA56-7B02D5CB6407@linaro.org>
 <1e743001-6284-d18b-1cfa-dc3edde3fd35@kernel.dk>
 <08D740DA-3918-47B8-867A-F1AAAA94E08D@linaro.org>
 <AF1C1826-49A6-4219-9BA0-0ABB86FDD1C3@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6f595f77-a25c-ac1b-7f14-5be0956f5995@kernel.dk>
Date: Fri, 27 Apr 2018 08:29:00 -0600
MIME-Version: 1.0
In-Reply-To: <AF1C1826-49A6-4219-9BA0-0ABB86FDD1C3@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/27/18 1:57 AM, Paolo Valente wrote:
> Should Jens' commit for bfq be still blocked by my concern, this is

The patch is in.

> just to inform you that I think I found a way to improve bfq, so that
> it can handle also requests that are prepared, but then disappear
> without any communication to bfq.  In particular, my change would

This is going about it in totally the wrong way. If things magically
disappear "without any communication to bfq", then it's either a bug in
the scheduling framework OR a bug in bfq. Those are the only two
options. Request don't magically appear or disappear, they follow a
specific set of rules.

> include Jens's change, so I will simply base my change on Jens' one,
> and I remove my disagreement.  Of course, Jens' change alone would
> just move the system from an immediate crash, to an unpredictable
> behavior, which may include later crashes.

Can we please stop with this nonsense. A (->priv[0]) and B (->priv[1])
are valid, IFF C (->elv.icq) is valid. The patch ensures we clear A and
B, if C isn't valid. There's nothing unpredictable about the patch.

-- 
Jens Axboe

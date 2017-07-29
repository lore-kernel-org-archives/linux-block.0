Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: consider also in_service_entity to
 state whether an entity is active
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lnicola@dend.ro,
 bfq-sched@lists.ewheeler.net, rick_yiu@htc.com, tom81094@gmail.com
References: <20170729104256.2002-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1050f3e1-9b7b-52e5-c09a-a01a853267cc@kernel.dk>
Date: Sat, 29 Jul 2017 15:33:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170729104256.2002-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/29/2017 04:42 AM, Paolo Valente wrote:
> Groups of BFQ queues are represented by generic entities in BFQ. When
> a queue belonging to a parent entity is deactivated, the parent entity
> may need to be deactivated too, in case the deactivated queue was the
> only active queue for the parent entity. This deactivation may need to
> be propagated upwards if the entity belongs, in its turn, to a further
> higher-level entity, and so on. In particular, the upward propagation
> of deactivation stops at the first parent entity that remains active
> even if one of its child entities has been deactivated.
> 
> To decide whether the last non-deactivation condition holds for a
> parent entity, BFQ checks whether the field next_in_service is still
> not NULL for the parent entity, after the deactivation of one of its
> child entity. If it is not NULL, then there are certainly other active
> entities in the parent entity, and deactivations can stop.
> 
> Unfortunately, this check misses a corner case: if in_service_entity
> is not NULL, then next_in_service may happen to be NULL, although the
> parent entity is evidently active. This happens if: 1) the entity
> pointed by in_service_entity is the only active entity in the parent
> entity, and 2) according to the definition of next_in_service, the
> in_service_entity cannot be considered as next_in_service. See the
> comments on the definition of next_in_service for details on this
> second point.
> 
> Hitting the above corner case causes crashes.
> 
> To address this issue, this commit:
> 1) Extends the above check on only next_in_service to controlling both
> next_in_service and in_service_entity (if any of them is not NULL,
> then no further deactivation is performed)
> 2) Improves the (important) comments on how next_in_service is defined
> and updated; in particular it fixes a few rather obscure paragraphs

Applied, thanks.

-- 
Jens Axboe

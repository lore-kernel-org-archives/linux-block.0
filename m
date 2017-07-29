Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: reset in_service_entity if it becomes
 idle
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lnicola@dend.ro
References: <20170728194118.8249-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c084df17-4c61-0640-fcac-a958477b9a7c@kernel.dk>
Date: Sat, 29 Jul 2017 15:33:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170728194118.8249-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/28/2017 01:41 PM, Paolo Valente wrote:
> BFQ implements hierarchical scheduling by representing each group of
> queues with a generic parent entity. For each parent entity, BFQ
> maintains an in_service_entity pointer: if one of the child entities
> happens to be in service, in_service_entity points to it.  The
> resetting of these pointers happens only on queue expirations: when
> the in-service queue is expired, i.e., stops to be the queue in
> service, BFQ resets all in_service_entity pointers along the
> parent-entity path from this queue to the root entity.
> 
> Functions handling the scheduling of entities assume, naturally, that
> in-service entities are active, i.e., have pending I/O requests (or,
> as a special case, even if they have no pending requests, they are
> expected to receive a new request very soon, with the scheduler idling
> the storage device while waiting for such an event). Unfortunately,
> the above resetting scheme of the in_service_entity pointers may cause
> this assumption to be violated.  For example, the in-service queue may
> happen to remain without requests because of a request merge. In this
> case the queue does become idle, and all related data structures are
> updated accordingly. But in_service_entity still points to the queue
> in the parent entity. This inconsistency may even propagate to
> higher-level parent entities, if they happen to become idle as well,
> as a consequence of the leaf queue becoming idle. For this queue and
> parent entities, scheduling functions have an undefined behaviour,
> and, as reported, may easily lead to kernel crashes or hangs.
> 
> This commit addresses this issue by simply resetting the
> in_service_entity field also when it is detected to point to an entity
> becoming idle (regardless of why the entity becomes idle).

Applied, thanks.

-- 
Jens Axboe

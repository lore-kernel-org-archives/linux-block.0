Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 02/16] block, bfq: add full hierarchical scheduling and cgroups support
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170411214702.GA31551@wtj.duckdns.org>
Date: Wed, 12 Apr 2017 07:22:03 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <1E0945A9-43F8-496D-B631-FB293921F304@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org> <20170411134315.44135-3-paolo.valente@linaro.org> <20170411214702.GA31551@wtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 11 apr 2017, alle ore 23:47, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Tue, Apr 11, 2017 at 03:43:01PM +0200, Paolo Valente wrote:
>> From: Arianna Avanzini <avanzini.arianna@gmail.com>
>>=20
>> Add complete support for full hierarchical scheduling, with a cgroups
>> interface. Full hierarchical scheduling is implemented through the
>> 'entity' abstraction: both bfq_queues, i.e., the internal BFQ queues
>> associated with processes, and groups are represented in general by
>> entities. Given the bfq_queues associated with the processes =
belonging
>> to a given group, the entities representing these queues are sons of
>> the entity representing the group. At higher levels, if a group, say
>> G, contains other groups, then the entity representing G is the =
parent
>> entity of the entities representing the groups in G.
>>=20
>> Hierarchical scheduling is performed as follows: if the timestamps of
>> a leaf entity (i.e., of a bfq_queue) change, and such a change lets
>> the entity become the next-to-serve entity for its parent entity, =
then
>> the timestamps of the parent entity are recomputed as a function of
>> the budget of its new next-to-serve leaf entity. If the parent entity
>> belongs, in its turn, to a group, and its new timestamps let it =
become
>> the next-to-serve for its parent entity, then the timestamps of the
>> latter parent entity are recomputed as well, and so on. When a new
>> bfq_queue must be set in service, the reverse path is followed: the
>> next-to-serve highest-level entity is chosen, then its next-to-serve
>> child entity, and so on, until the next-to-serve leaf entity is
>> reached, and the bfq_queue that this entity represents is set in
>> service.
>>=20
>> Writeback is accounted for on a per-group basis, i.e., for each =
group,
>> the async I/O requests of the processes of the group are enqueued in =
a
>> distinct bfq_queue, and the entity associated with this queue is a
>> child of the entity associated with the group.
>>=20
>> Weights can be assigned explicitly to groups and processes through =
the
>> cgroups interface, differently from what happens, for single
>> processes, if the cgroups interface is not used (as explained in the
>> description of the previous patch). In particular, since each node =
has
>> a full scheduler, each group can be assigned its own weight.
>=20
> Can we please hold off on cgroup support for now?  I've been trying to
> chase down cpu scheduler latency issues lately and have some doubts
> about implementing cgroup support by simply nesting the timelines like
> this.
>=20

Hi Tejun,
could you elaborate a bit more on this?  I mean, cgroups support has
been in BFQ (and CFQ) for almost ten years, perfectly working as far
as I know.  Of course it is perfectly working in terms of I/O and not
of CPU bandwidth distribution; and, for the moment, it is effective
only for devices below 30-50KIOPS.  What's the point in throwing
(momentarily?) away such a fundamental feature?  What am I missing?

Thanks,
Paolo


> Thanks
>=20
> --=20
> tejun

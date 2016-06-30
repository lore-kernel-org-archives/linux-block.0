Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 30 Jun 2016 19:48:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
Message-ID: <20160630174854.GA23578@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <20160625200518.GA29251@dhcp-27-118.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20160625200518.GA29251@dhcp-27-118.brq.redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 tglx@linutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 25, 2016 at 10:05:19PM +0200, Alexander Gordeev wrote:
> > + * and generate an output cpumask suitable for spreading MSI/MSI-X vectors
> > + * so that they are distributed as good as possible around the CPUs.  If
> > + * more vectors than CPUs are available we'll map one to each CPU,
> 
> Unless I do not misinterpret a loop from msix_setup_entries() (patch 08/13),
> the above is incorrect:

What part do you think is incorrect?

> > + * otherwise we map one to the first sibling of each socket.
> 
> (*) I guess, in some topology configurations a total number of all
> first siblings may be less than the number of vectors.

Yes, in that case we'll assign imcompetely.  I've already heard people
complaining about that at LSF/MM, but no one volunteered patches.
I only have devices with 1 or enough vectores to test, so I don't
really dare to touch the algorithm.  Either way the algorithm
change should probably be a different patch than refactoring it and
moving it around.

> > + * If there are more vectors than CPUs we will still only have one bit
> > + * set per CPU, but interrupt code will keep on assining the vectors from
> > + * the start of the bitmap until we run out of vectors.
> > + */
> > +int irq_create_affinity_mask(struct cpumask **affinity_mask,
> > +		unsigned int *nr_vecs)
> 
> Both the callers of this function and the function itself IMHO would
> read better if it simply returned the affinity mask. Or passed the 
> affinity mask pointer.

We can't just return the pointer as NULL is a valid and common return
value.  If we pass the pointer we'd then also need to allocate one for
the (common) nvec = 1 case.

> 
> > +{
> > +	unsigned int vecs = 0;
> 
> In case (*nr_vecs >= num_online_cpus()) the contents of *nr_vecs
> will be overwritten with 0.

Thanks, fixed.

> So considering (*) comment above the number of available vectors
> might be unnecessarily shrunken here.
> 
> I think nr_vecs need not be an out-parameter since we always can
> assign multiple vectors to a CPU. It is better than limiting number
> of available vectors AFAIKT. Or you could pass one-per-cpu flag
> explicitly.

The function is intended to replicate the blk-mq algorithm.  I don't
think it's optimal, but I really want to avoid dragging the discussion
about the optimal algorithm into this patchset.  We should at least
move to a vector per node/socket model instead of just the siblings,
and be able to use all vectors (at least optionally).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

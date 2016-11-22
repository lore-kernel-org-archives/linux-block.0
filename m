Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH 00/12] block: cleanup direct access to bvec table
To: Ming Lei <tom.leiming@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <167c2511-349f-a8e6-17d1-f7ce438b2f14@fb.com>
Date: Tue, 22 Nov 2016 08:53:00 -0700
MIME-Version: 1.0
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Mike Snitzer <snitzer@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, "open
 list:NVM EXPRESS TARGET DRIVER" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>, "open
 list:DEVICE-MAPPER \(LVM\)" <dm-devel@redhat.com>, "open
 list:TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>,
 "open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
 Hannes Reinecke <hare@suse.com>,
 "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Mike Christie <mchristi@redhat.com>,
 Guoqing Jiang <gqjiang@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Coly Li <colyli@suse.de>, "open
 list:SOFTWARE RAID \(Multiple Disks\) SUPPORT" <linux-raid@vger.kernel.org>,
 "open list:BCACHE \(BLOCK LAYER CACHE\)" <linux-bcache@vger.kernel.org>,
 linux-block@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
 Adrian Hunter <adrian.hunter@intel.com>, "open list:LogFS" <logfs@logfs.org>,
 Zheng Liu <wenqing.lz@taobao.com>, linux-fsdevel@vger.kernel.org,
 Eric Wheeler <git@linux.ewheeler.net>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 05:05 AM, Ming Lei wrote:
> Hi,
>
> This patchset cleans up direct access to bvec table.
>
> The 1st patch passes bvec table to bio_init(), so that
> direct access to bvec table in bio initialization is avoided.
>
> For other patches, most of them uses bio_add_page()
> to replace hardcode style of adding page to bvec,
> and others avoids to access bio->bi_vcnt.
>
> The most special one is to use bvec iterator helpers
> to implement .get_page/.next_page for dm-io.c
>
> One big motivation is to prepare for supporting multipage
> bvec, but this patchset is one good cleanup too even not
> for that purpose.

I've added the series, except 6-8, the dm parts. I updated some of the
descriptions/subjects to read a little better.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

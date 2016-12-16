Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Message-ID: <b2755703b7823eb26f282218ef29362b.squirrel@webmail.raithlin.com>
In-Reply-To: <365e0b2b-06b1-dc0b-a9ae-dc901ca98d6a@fb.com>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <365e0b2b-06b1-dc0b-a9ae-dc901ca98d6a@fb.com>
Date: Fri, 16 Dec 2016 13:37:46 -0600
Subject: Re: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
From: "Stephen Bates" <sbates@raithlin.com>
To: "Jens Axboe" <axboe@fb.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 james_p_freyensee@linux.intel.com, jonathan.derrick@intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

>> Jens I based this off v4.9 because for some reason your for-4.10/block
>> is missing my original CMB commit (202021c1a63c6)?
>
> for-4.10/block was forked off v4.9-rc1, and that patch didn't make it in
> until v4.9-rc2. Since for-4.10/block has been merged, any patches for this
> series or next should be based on my for-linus, or just master.
>
> Assuming these two apply directly to master as well?
>
>

Ah thanks for clearing up my confusion ;-). Yes, this series applies
cleanly to both your master and for-linus branches.


Stephen

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

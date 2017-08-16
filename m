Return-Path: <chris@chris-wilson.co.uk>
Return-Path: <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Chris Mi" <chrism@mellanox.com>, netdev@vger.kernel.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <144b87a3-bbe4-a194-ed83-e54840d7c7c2@amd.com>
Cc: aditr@vmware.com, stern@rowland.harvard.edu, agk@redhat.com,
 alexander.shishkin@linux.intel.com, alexandre.bounine@idt.com,
 alexander.deucher@amd.com, oakad@yahoo.com, ast@kernel.org, elder@kernel.org,
 adobriyan@gmail.com, alex.williamson@redhat.com, AlexBin.Xie@amd.com,
 viro@zeniv.linux.org.uk, amd-gfx@lists.freedesktop.org, amitkarwar@gmail.com,
 andresx7@gmail.com, andrew.donnellan@au1.ibm.com, afd@ti.com,
 akpm@linux-foundation.org, anil.gurumurthy@qlogic.com,
 anna.schumaker@netapp.com, acme@kernel.org, arnd@arndb.de,
 dedekind1@gmail.com, ashutosh.dixit@intel.com, ath10k@lists.infradead.org,
 Bart.VanAssche@sandisk.com, bhaktipriya96@gmail.com,
 bjorn.andersson@linaro.org, boris.brezillon@free-electrons.com,
 computersforpeace@gmail.com, bryan.thompson@unisys.com,
 cgroups@vger.kernel.org, 3chas3@gmail.com, ccaulfie@redhat.com,
 david1.zhou@amd.com, cluster-devel@redhat.com, colin.king@canonical.com,
 xiyou.wangcong@gmail.com, cyrille.pitchen@wedev4u.fr, daniel@iogearbox.net,
 daniel.vetter@intel.com, dasaratharaman.chandramouli@intel.com,
 airlied@redhat.com, dsa@cumulusnetworks.com, airlied@linux.ie,
 david.binder@unisys.com, dhowells@redhat.com, david.kershner@unisys.com,
 dtwlin@gmail.com, dave@stgolabs.net, davem@davemloft.net,
 teigland@redhat.com, dwindsor@gmail.com, dwmw2@infradead.org,
 dennis.dalessandro@intel.com, devel@driverdev.osuosl.org,
 devesh.sharma@broadcom.com, devicetree@vger.kernel.org,
 dick.kennedy@broadcom.com, dm-devel@redhat.com, don.hiatt@intel.com,
 dgilbert@interlog.com, dledford@redhat.com, drbd-dev@lists.linbit.com,
 dri-devel@lists.freedesktop.org, elena.reshetova@intel.com,
 edumazet@google.com, eparis@parisplace.org, ericvh@gmail.com,
 ebiederm@xmission.com, evan.quan@amd.com, felipe.balbi@linux.intel.com,
 Felix.Kuehling@amd.com, f.fainelli@gmail.com, fw@strlen.de,
 frowand.list@gmail.com, fbarrat@linux.vnet.ibm.com,
 fujita.tomonori@lab.ntt.co.jp, gbhat@marvell.com, geliangtang@gmail.com,
 kraxel@redhat.com, gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
 linux@roeck-us.net, gustavo.padovan@collabora.co.uk,
 hal.rosenstock@gmail.com, hannes@stressinduktion.org, hare@suse.de,
 ishkamiel@gmail.com, hans.westgaard.ry@oracle.com, ray.huang@amd.com,
 mingo@redhat.com, inki.dae@samsung.com, intel-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 ira.weiny@intel.com, jinpu.wang@profitbricks.com, jhs@mojatatu.com,
 jejb@linux.vnet.ibm.com, james.smart@broadcom.com,
 jani.nikula@linux.intel.com, jack@suse.cz, jarkko.sakkinen@linux.intel.com,
 jarno@ovn.org, Jason@zx2c4.com, jgunthorpe@obsidianresearch.com,
 jasowang@redhat.com, javier@osg.samsung.com, bfields@fieldses.org,
 jlayton@poochiereds.net, axboe@kernel.dk, jens.wiklander@linaro.org,
 jiangyilism@gmail.com, jiri@mellanox.com, jiri@resnulli.us,
 jlbec@evilplan.org, joro@8bytes.org, johan@kernel.org,
 johannes@sipsolutions.net, hannes@cmpxchg.org, john@johnmccutchan.com,
 jonathanh@nvidia.com, jon.maloy@ericsson.com,
 joonas.lahtinen@linux.intel.com, jy0922.shim@samsung.com, jbacik@fb.com,
 Jerry.Zhang@amd.com, jsarha@ti.com, Kai.Makisara@kolumbus.fi,
 kvalo@qca.qualcomm.com, keescook@chromium.org, krzk@kernel.org,
 kgene@kernel.org, kvm@vger.kernel.org, kyungmin.park@samsung.com,
 jiangshanlai@gmail.com, lars.ellenberg@linbit.com, lucho@ionkov.net,
 lee.jones@linaro.org, leo.liu@amd.com, leon@kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-atm-general@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-ppp@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sctp@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 logang@deltatee.com, majd@mellanox.com, manfred@colorfullife.com,
 tpmdd@selhorst.net, marcos.souza.org@gmail.com, marek.vasut@gmail.com,
 mario.kleiner.de@gmail.com, markb@mellanox.com, mfasheh@versity.com,
 elfring@users.sourceforge.net, martin.petersen@oracle.com,
 matan@mellanox.com, mawilcox@microsoft.com, mporter@kernel.crashing.org,
 mchehab@kernel.org, maximlevitsky@gmail.com, mst@redhat.com,
 mhocko@kernel.org, michel.daenzer@amd.com, mike.marciniszyn@intel.com,
 rppt@linux.vnet.ibm.com, snitzer@redhat.com, mszeredi@redhat.com,
 minchan@kernel.org, tom.leiming@gmail.com, monis@mellanox.com,
 Monk.Liu@amd.com, nbd-general@lists.sourceforge.net, neilb@suse.com,
 nhorman@tuxdriver.com, nab@linux-iscsi.org, nicolai.haehnle@amd.com,
 nicolas.dichtel@6wind.com, niranjana.vishwanathapura@intel.com,
 nishants@marvell.com, ngupta@vflare.org, ocfs2-devel@oss.oracle.com,
 ohad@wizery.com, oneukum@suse.com, osandov@fb.com, ogerlitz@mellanox.com,
 pali.rohar@gmail.com, pantelis.antoniou@konsulko.com, paulus@samba.org,
 paul@paul-moore.com, peterhuewe@gmx.de, peterz@infradead.org,
 pmladek@suse.com, philipp.reisner@linbit.com, pshelar@ovn.org,
 rjw@rjwysocki.net, richard@nod.at, rlove@rlove.org, robh+dt@kernel.org,
 giometti@enneenne.com, rogerq@ti.com, roman.kapl@sysgo.com,
 rminnich@sandia.gov, rmk+kernel@armlinux.org.uk, sainath.grandhi@intel.com,
 sameer.wadgaonkar@unisys.com, sean.hefty@intel.com, seanpaul@chromium.org,
 bigeasy@linutronix.de, sre@kernel.org, nsekhar@ti.com,
 selvin.xavier@broadcom.com, sergey.senozhatsky.work@gmail.com,
 sw0312.kim@samsung.com, p.shailesh@samsung.com, shli@kernel.org,
 shaun.tancheff@seagate.com, syeh@vmware.com, sparmaintainer@unisys.com,
 stefanr@s5r6.in-berlin.de, sboyd@codeaurora.org, stephen@networkplumber.org,
 swise@chelsio.com, sudarsana.kalluru@qlogic.com, sudeep.dutt@intel.com,
 sumit.semwal@linaro.org, target-devel@vger.kernel.org, tj@kernel.org,
 thierry.reding@gmail.com, thellstrom@vmware.com, timothy.sell@unisys.com,
 tipc-discussion@lists.sourceforge.net, tomas.winkler@intel.com,
 tomi.valkeinen@ti.com, tpmdd-devel@lists.sourceforge.net,
 trond.myklebust@primarydata.com, v9fs-developer@lists.sourceforge.net,
 varun@chelsio.com, virtualization@lists.linux-foundation.org,
 vdavydov.dev@gmail.com, vyasevich@gmail.com,
 linux-graphics-maintainer@vmware.com, longman@redhat.com, weiyj.lk@gmail.com,
 wsa@the-dreams.de, huxm@marvell.com, ying.xue@windriver.com,
 yishaih@mellanox.com, yuval.shaia@oracle.com, lizefan@huawei.com,
 zhenyuw@linux.intel.com, zhi.a.wang@intel.com
References: <1502849538-14284-1-git-send-email-chrism@mellanox.com>
 <144b87a3-bbe4-a194-ed83-e54840d7c7c2@amd.com>
Message-ID: <150287519355.15499.3124883464555211520@mail.alporthouse.com>
Subject: Re: [patch net-next 0/3] net/sched: Improve getting objects by indexes
Date: Wed, 16 Aug 2017 10:19:53 +0100
List-ID: <linux-block@vger.kernel.org>

Quoting Christian K=C3=B6nig (2017-08-16 08:49:07)
> Am 16.08.2017 um 04:12 schrieb Chris Mi:
> > Using current TC code, it is very slow to insert a lot of rules.
> >
> > In order to improve the rules update rate in TC,
> > we introduced the following two changes:
> >          1) changed cls_flower to use IDR to manage the filters.
> >          2) changed all act_xxx modules to use IDR instead of
> >             a small hash table
> >
> > But IDR has a limitation that it uses int. TC handle uses u32.
> > To make sure there is no regression, we also changed IDR to use
> > unsigned long. All clients of IDR are changed to use new IDR API.
> =

> WOW, wait a second. The idr change is touching a lot of drivers and to =

> be honest doesn't looks correct at all.
> =

> Just look at the first chunk of your modification:
> > @@ -998,8 +999,9 @@ int bsg_register_queue(struct request_queue *q, str=
uct device *parent,
> >   =

> >       mutex_lock(&bsg_mutex);
> >   =

> > -     ret =3D idr_alloc(&bsg_minor_idr, bcd, 0, BSG_MAX_DEVS, GFP_KERNE=
L);
> > -     if (ret < 0) {
> > +     ret =3D idr_alloc(&bsg_minor_idr, bcd, &idr_index, 0, BSG_MAX_DEV=
S,
> > +                     GFP_KERNEL);
> > +     if (ret) {
> >               if (ret =3D=3D -ENOSPC) {
> >                       printk(KERN_ERR "bsg: too many bsg devices\n");
> >                       ret =3D -EINVAL;
> The condition "if (ret)" will now always be true after the first =

> allocation and so we always run into the error handling after that.

ret is now purely the error code, so it doesn't look that suspicious.

> I've never read the bsg code before, but that's certainly not correct. =

> And that incorrect pattern repeats over and over again in this code.
> =

> Apart from that why the heck do you want to allocate more than 1<<31 =

> handles?

And more to the point, arbitrarily changing the maximum to ULONG_MAX
where the ABI only supports U32_MAX is dangerous. Unless you do the
analysis otherwise, you have to replace all the end=3D0 with end=3DINT_MAX
to maintain existing behaviour.
-Chris

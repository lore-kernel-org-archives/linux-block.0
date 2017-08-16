Return-Path: <chrism@mellanox.com>
From: Chris Mi <chrism@mellanox.com>
To: netdev@vger.kernel.org
Cc: aditr@vmware.com, stern@rowland.harvard.edu, agk@redhat.com,
        alexander.shishkin@linux.intel.com, alexandre.bounine@idt.com,
        alexander.deucher@amd.com, oakad@yahoo.com, ast@kernel.org,
        elder@kernel.org, adobriyan@gmail.com, alex.williamson@redhat.com,
        AlexBin.Xie@amd.com, viro@zeniv.linux.org.uk,
        amd-gfx@lists.freedesktop.org, amitkarwar@gmail.com,
        andresx7@gmail.com, andrew.donnellan@au1.ibm.com, afd@ti.com,
        akpm@linux-foundation.org, anil.gurumurthy@qlogic.com,
        anna.schumaker@netapp.com, acme@kernel.org, arnd@arndb.de,
        dedekind1@gmail.com, ashutosh.dixit@intel.com,
        ath10k@lists.infradead.org, Bart.VanAssche@sandisk.com,
        bhaktipriya96@gmail.com, bjorn.andersson@linaro.org,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        bryan.thompson@unisys.com, cgroups@vger.kernel.org, 3chas3@gmail.com,
        chrism@mellanox.com, christian.koenig@amd.com, ccaulfie@redhat.com,
        chris@chris-wilson.co.uk, david1.zhou@amd.com,
        cluster-devel@redhat.com, colin.king@canonical.com,
        xiyou.wangcong@gmail.com, cyrille.pitchen@wedev4u.fr,
        daniel@iogearbox.net, daniel.vetter@intel.com,
        dasaratharaman.chandramouli@intel.com, airlied@redhat.com,
        dsa@cumulusnetworks.com, airlied@linux.ie, david.binder@unisys.com,
        dhowells@redhat.com, david.kershner@unisys.com, dtwlin@gmail.com,
        dave@stgolabs.net, davem@davemloft.net, teigland@redhat.com,
        dwindsor@gmail.com, dwmw2@infradead.org, dennis.dalessandro@intel.com,
        devel@driverdev.osuosl.org, devesh.sharma@broadcom.com,
        devicetree@vger.kernel.org, dick.kennedy@broadcom.com,
        dm-devel@redhat.com, don.hiatt@intel.com, dgilbert@interlog.com,
        dledford@redhat.com, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, elena.reshetova@intel.com,
        edumazet@google.com, eparis@parisplace.org, ericvh@gmail.com,
        ebiederm@xmission.com, evan.quan@amd.com, felipe.balbi@linux.intel.com,
        Felix.Kuehling@amd.com, f.fainelli@gmail.com, fw@strlen.de,
        frowand.list@gmail.com, fbarrat@linux.vnet.ibm.com,
        fujita.tomonori@lab.ntt.co.jp, gbhat@marvell.com,
        geliangtang@gmail.com, kraxel@redhat.com, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux@roeck-us.net,
        gustavo.padovan@collabora.co.uk, hal.rosenstock@gmail.com,
        hannes@stressinduktion.org, hare@suse.de, ishkamiel@gmail.com,
        hans.westgaard.ry@oracle.com, ray.huang@amd.com, mingo@redhat.com,
        inki.dae@samsung.com, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        ira.weiny@intel.com, jinpu.wang@profitbricks.com, jhs@mojatatu.com,
        jejb@linux.vnet.ibm.com, james.smart@broadcom.com,
        jani.nikula@linux.intel.com, jack@suse.cz,
        jarkko.sakkinen@linux.intel.com, jarno@ovn.org, Jason@zx2c4.com,
        jgunthorpe@obsidianresearch.com, jasowang@redhat.com,
        javier@osg.samsung.com, bfields@fieldses.org, jlayton@poochiereds.net,
        axboe@kernel.dk, jens.wiklander@linaro.org, jiangyilism@gmail.com,
        jiri@mellanox.com, jiri@resnulli.us, jlbec@evilplan.org,
        joro@8bytes.org, johan@kernel.org, johannes@sipsolutions.net,
        hannes@cmpxchg.org, john@johnmccutchan.com, jonathanh@nvidia.com,
        jon.maloy@ericsson.com, joonas.lahtinen@linux.intel.com,
        jy0922.shim@samsung.com, jbacik@fb.com, Jerry.Zhang@amd.com,
        jsarha@ti.com, Kai.Makisara@kolumbus.fi, kvalo@qca.qualcomm.com,
        keescook@chromium.org, krzk@kernel.org, kgene@kernel.org,
        kvm@vger.kernel.org, kyungmin.park@samsung.com, jiangshanlai@gmail.com,
        lars.ellenberg@linbit.com, lucho@ionkov.net, lee.jones@linaro.org,
        leo.liu@amd.com, leon@kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-ppp@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, logang@deltatee.com, majd@mellanox.com,
        manfred@colorfullife.com, tpmdd@selhorst.net,
        marcos.souza.org@gmail.com, marek.vasut@gmail.com,
        mario.kleiner.de@gmail.com, markb@mellanox.com, mfasheh@versity.com,
        elfring@users.sourceforge.net, martin.petersen@oracle.com,
        matan@mellanox.com, mawilcox@microsoft.com,
        mporter@kernel.crashing.org, mchehab@kernel.org,
        maximlevitsky@gmail.com, mst@redhat.com, mhocko@kernel.org,
        michel.daenzer@amd.com, mike.marciniszyn@intel.com,
        rppt@linux.vnet.ibm.com, snitzer@redhat.com, mszeredi@redhat.com,
        minchan@kernel.org, tom.leiming@gmail.com, monis@mellanox.com,
        Monk.Liu@amd.com, nbd-general@lists.sourceforge.net, neilb@suse.com,
        nhorman@tuxdriver.com, nab@linux-iscsi.org, nicolai.haehnle@amd.com,
        nicolas.dichtel@6wind.com, niranjana.vishwanathapura@intel.com,
        nishants@marvell.com, ngupta@vflare.org, ocfs2-devel@oss.oracle.com,
        ohad@wizery.com, oneukum@suse.com, osandov@fb.com,
        ogerlitz@mellanox.com, pali.rohar@gmail.com,
        pantelis.antoniou@konsulko.com, paulus@samba.org, paul@paul-moore.com,
        peterhuewe@gmx.de, peterz@infradead.org, pmladek@suse.com,
        philipp.reisner@linbit.com, pshelar@ovn.org, rjw@rjwysocki.net,
        richard@nod.at, rlove@rlove.org, robh+dt@kernel.org,
        giometti@enneenne.com, rogerq@ti.com, roman.kapl@sysgo.com,
        rminnich@sandia.gov, rmk+kernel@armlinux.org.uk,
        sainath.grandhi@intel.com, sameer.wadgaonkar@unisys.com,
        sean.hefty@intel.com, seanpaul@chromium.org, bigeasy@linutronix.de,
        sre@kernel.org, nsekhar@ti.com, selvin.xavier@broadcom.com,
        sergey.senozhatsky.work@gmail.com, sw0312.kim@samsung.com,
        p.shailesh@samsung.com, shli@kernel.org, shaun.tancheff@seagate.com,
        syeh@vmware.com, sparmaintainer@unisys.com, stefanr@s5r6.in-berlin.de,
        sboyd@codeaurora.org, stephen@networkplumber.org, swise@chelsio.com,
        sudarsana.kalluru@qlogic.com, sudeep.dutt@intel.com,
        sumit.semwal@linaro.org, target-devel@vger.kernel.org, tj@kernel.org,
        thierry.reding@gmail.com, thellstrom@vmware.com,
        timothy.sell@unisys.com, tipc-discussion@lists.sourceforge.net,
        tomas.winkler@intel.com, tomi.valkeinen@ti.com,
        tpmdd-devel@lists.sourceforge.net, trond.myklebust@primarydata.com,
        v9fs-developer@lists.sourceforge.net, varun@chelsio.com,
        virtualization@lists.linux-foundation.org, vdavydov.dev@gmail.com,
        vyasevich@gmail.com, linux-graphics-maintainer@vmware.com,
        longman@redhat.com, weiyj.lk@gmail.com, wsa@the-dreams.de,
        huxm@marvell.com, ying.xue@windriver.com, yishaih@mellanox.com,
        yuval.shaia@oracle.com, lizefan@huawei.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com
Subject: [patch net-next 0/3] net/sched: Improve getting objects by indexes
Date: Tue, 15 Aug 2017 22:12:15 -0400
Message-Id: <1502849538-14284-1-git-send-email-chrism@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Using current TC code, it is very slow to insert a lot of rules.

In order to improve the rules update rate in TC,
we introduced the following two changes:
        1) changed cls_flower to use IDR to manage the filters.
        2) changed all act_xxx modules to use IDR instead of
           a small hash table

But IDR has a limitation that it uses int. TC handle uses u32.
To make sure there is no regression, we also changed IDR to use
unsigned long. All clients of IDR are changed to use new IDR API.

Chris Mi (3):
  idr: Use unsigned long instead of int
  net/sched: Change cls_flower to use IDR
  net/sched: Change act_api and act_xxx modules to use IDR

 block/bsg.c                                     |   8 +-
 block/genhd.c                                   |  12 +-
 drivers/atm/nicstar.c                           |  11 +-
 drivers/block/drbd/drbd_main.c                  |  31 +--
 drivers/block/drbd/drbd_nl.c                    |  22 ++-
 drivers/block/drbd/drbd_proc.c                  |   3 +-
 drivers/block/drbd/drbd_receiver.c              |  15 +-
 drivers/block/drbd/drbd_state.c                 |  34 ++--
 drivers/block/drbd/drbd_worker.c                |   6 +-
 drivers/block/loop.c                            |  17 +-
 drivers/block/nbd.c                             |  20 +-
 drivers/block/zram/zram_drv.c                   |   9 +-
 drivers/char/tpm/tpm-chip.c                     |  10 +-
 drivers/char/tpm/tpm.h                          |   2 +-
 drivers/dca/dca-sysfs.c                         |   9 +-
 drivers/firewire/core-cdev.c                    |  18 +-
 drivers/firewire/core-device.c                  |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c         |   2 +-
 drivers/gpu/drm/drm_auth.c                      |   9 +-
 drivers/gpu/drm/drm_connector.c                 |  10 +-
 drivers/gpu/drm/drm_context.c                   |  20 +-
 drivers/gpu/drm/drm_dp_aux_dev.c                |  11 +-
 drivers/gpu/drm/drm_drv.c                       |   6 +-
 drivers/gpu/drm/drm_gem.c                       |  19 +-
 drivers/gpu/drm/drm_info.c                      |   2 +-
 drivers/gpu/drm/drm_mode_object.c               |  11 +-
 drivers/gpu/drm/drm_syncobj.c                   |  18 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c         |  25 ++-
 drivers/gpu/drm/i915/gvt/display.c              |   2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                |   2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                 |   9 +-
 drivers/gpu/drm/i915/i915_debugfs.c             |   6 +-
 drivers/gpu/drm/i915/i915_gem_context.c         |   9 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                   |   8 +-
 drivers/gpu/drm/qxl/qxl_release.c               |  14 +-
 drivers/gpu/drm/sis/sis_mm.c                    |   8 +-
 drivers/gpu/drm/tegra/drm.c                     |  10 +-
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c    |   3 +-
 drivers/gpu/drm/vgem/vgem_fence.c               |  12 +-
 drivers/gpu/drm/via/via_mm.c                    |   8 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c            |   5 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c             |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c        |   9 +-
 drivers/i2c/i2c-core-base.c                     |  19 +-
 drivers/infiniband/core/cm.c                    |   8 +-
 drivers/infiniband/core/cma.c                   |  12 +-
 drivers/infiniband/core/rdma_core.c             |   9 +-
 drivers/infiniband/core/sa_query.c              |  23 +--
 drivers/infiniband/core/ucm.c                   |   7 +-
 drivers/infiniband/core/ucma.c                  |  14 +-
 drivers/infiniband/hw/cxgb3/iwch.c              |   4 +-
 drivers/infiniband/hw/cxgb3/iwch.h              |   4 +-
 drivers/infiniband/hw/cxgb4/device.c            |  18 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |   4 +-
 drivers/infiniband/hw/hfi1/init.c               |   9 +-
 drivers/infiniband/hw/hfi1/vnic_main.c          |   6 +-
 drivers/infiniband/hw/mlx4/cm.c                 |  13 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c      |   7 +-
 drivers/infiniband/hw/qib/qib_init.c            |   9 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c |  10 +-
 drivers/iommu/intel-svm.c                       |   9 +-
 drivers/md/dm.c                                 |  13 +-
 drivers/memstick/core/memstick.c                |  10 +-
 drivers/memstick/core/ms_block.c                |   9 +-
 drivers/memstick/core/mspro_block.c             |  12 +-
 drivers/mfd/rtsx_pcr.c                          |   9 +-
 drivers/misc/c2port/core.c                      |   7 +-
 drivers/misc/cxl/context.c                      |   8 +-
 drivers/misc/cxl/main.c                         |  15 +-
 drivers/misc/mei/main.c                         |   8 +-
 drivers/misc/mic/scif/scif_api.c                |  11 +-
 drivers/misc/mic/scif/scif_ports.c              |  18 +-
 drivers/misc/tifm_core.c                        |   9 +-
 drivers/mtd/mtdcore.c                           |   9 +-
 drivers/mtd/mtdcore.h                           |   2 +-
 drivers/mtd/ubi/block.c                         |   7 +-
 drivers/net/ppp/ppp_generic.c                   |  27 +--
 drivers/net/tap.c                               |  10 +-
 drivers/net/wireless/ath/ath10k/htt.h           |   3 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c        |  22 ++-
 drivers/net/wireless/ath/ath10k/mac.c           |   2 +-
 drivers/net/wireless/marvell/mwifiex/main.c     |  13 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c      |   2 +-
 drivers/of/overlay.c                            |  15 +-
 drivers/of/unittest.c                           |  25 ++-
 drivers/power/supply/bq2415x_charger.c          |  16 +-
 drivers/power/supply/bq27xxx_battery_i2c.c      |  15 +-
 drivers/power/supply/ds2782_battery.c           |   9 +-
 drivers/powercap/powercap_sys.c                 |   8 +-
 drivers/pps/pps.c                               |  10 +-
 drivers/rapidio/rio_cm.c                        |  17 +-
 drivers/remoteproc/remoteproc_core.c            |   8 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                |   8 +-
 drivers/scsi/bfa/bfad_im.c                      |   8 +-
 drivers/scsi/ch.c                               |   8 +-
 drivers/scsi/lpfc/lpfc_crtn.h                   |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                   |  11 +-
 drivers/scsi/lpfc/lpfc_vport.c                  |   8 +-
 drivers/scsi/sg.c                               |  10 +-
 drivers/scsi/st.c                               |   8 +-
 drivers/staging/greybus/uart.c                  |  22 +--
 drivers/staging/unisys/visorhba/visorhba_main.c |   7 +-
 drivers/target/iscsi/iscsi_target.c             |   7 +-
 drivers/target/iscsi/iscsi_target_login.c       |   9 +-
 drivers/target/target_core_device.c             |   9 +-
 drivers/target/target_core_user.c               |  13 +-
 drivers/tee/tee_shm.c                           |   8 +-
 drivers/uio/uio.c                               |   9 +-
 drivers/usb/class/cdc-acm.c                     |  24 +--
 drivers/usb/core/devices.c                      |   2 +-
 drivers/usb/core/hcd.c                          |   7 +-
 drivers/usb/mon/mon_main.c                      |   3 +-
 drivers/usb/serial/usb-serial.c                 |  11 +-
 drivers/vfio/vfio.c                             |  15 +-
 fs/dlm/lock.c                                   |   9 +-
 fs/dlm/lockspace.c                              |   6 +-
 fs/dlm/recover.c                                |  10 +-
 fs/nfs/nfs4client.c                             |   9 +-
 fs/nfsd/nfs4state.c                             |   8 +-
 fs/notify/inotify/inotify_fsnotify.c            |   4 +-
 fs/notify/inotify/inotify_user.c                |   9 +-
 fs/ocfs2/cluster/tcp.c                          |  10 +-
 include/linux/idr.h                             |  26 +--
 include/linux/of.h                              |   4 +-
 include/linux/radix-tree.h                      |   2 +-
 include/net/9p/9p.h                             |   2 +-
 include/net/act_api.h                           |  76 +++-----
 ipc/msg.c                                       |   2 +-
 ipc/sem.c                                       |   2 +-
 ipc/shm.c                                       |   4 +-
 ipc/util.c                                      |  17 +-
 kernel/bpf/syscall.c                            |  20 +-
 kernel/cgroup/cgroup.c                          |  57 +++---
 kernel/events/core.c                            |  10 +-
 kernel/workqueue.c                              |  15 +-
 lib/idr.c                                       |  38 ++--
 lib/radix-tree.c                                |   5 +-
 mm/memcontrol.c                                 |  11 +-
 net/9p/client.c                                 |  17 +-
 net/9p/util.c                                   |  14 +-
 net/core/net_namespace.c                        |  23 ++-
 net/mac80211/cfg.c                              |  23 +--
 net/mac80211/iface.c                            |   3 +-
 net/mac80211/main.c                             |   2 +-
 net/mac80211/tx.c                               |   7 +-
 net/mac80211/util.c                             |   3 +-
 net/netlink/genetlink.c                         |  18 +-
 net/qrtr/qrtr.c                                 |  21 +-
 net/rxrpc/conn_client.c                         |  15 +-
 net/sched/act_api.c                             | 249 +++++++++++-------------
 net/sched/act_bpf.c                             |  17 +-
 net/sched/act_connmark.c                        |  16 +-
 net/sched/act_csum.c                            |  16 +-
 net/sched/act_gact.c                            |  16 +-
 net/sched/act_ife.c                             |  20 +-
 net/sched/act_ipt.c                             |  26 ++-
 net/sched/act_mirred.c                          |  19 +-
 net/sched/act_nat.c                             |  16 +-
 net/sched/act_pedit.c                           |  18 +-
 net/sched/act_police.c                          |  18 +-
 net/sched/act_sample.c                          |  17 +-
 net/sched/act_simple.c                          |  20 +-
 net/sched/act_skbedit.c                         |  18 +-
 net/sched/act_skbmod.c                          |  18 +-
 net/sched/act_tunnel_key.c                      |  20 +-
 net/sched/act_vlan.c                            |  22 +--
 net/sched/cls_flower.c                          |  55 +++---
 net/sctp/associola.c                            |   8 +-
 net/tipc/server.c                               |   7 +-
 172 files changed, 1256 insertions(+), 1113 deletions(-)

-- 
1.8.3.1

Return-Path: <pavel@ucw.cz>
Date: Sat, 17 Feb 2018 22:19:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: elfring@users.sourceforge.net,
	kernel list <linux-kernel@vger.kernel.org>, vgupta@synopsys.com,
	linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
	will.deacon@arm.com, paulus@ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, ard.biesheuvel@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@kernel.dk,
	daniel.lezcano@linaro.org, maxime.ripard@free-electrons.com,
	wens@csie.org, alexander.deucher@amd.com, christian.koenig@amd.com,
	David1.Zhou@amd.com, airlied@linux.ie, robdclark@gmail.com,
	joro@8bytes.org, shli@kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, fabio.estevam@nxp.com,
	akpm@linux-foundation.org, Alexey.Brodkin@synopsys.com,
	mhocko@suse.com, vbabka@suse.cz, Vladislav.Zakharov@synopsys.com,
	noamca@mellanox.com, yamada.masahiro@socionext.com,
	sboyd@codeaurora.org, viresh.kumar@linaro.org,
	linus.walleij@linaro.org, heiko@sntech.de, aik@ozlabs.ru,
	ruscur@russell.cc, david@gibson.dropbear.id.au,
	fbarrat@linux.vnet.ibm.com, alistair@popple.id.au, robh@kernel.org,
	joe@perches.com, harry.wentland@amd.com, tony.cheng@amd.com,
	Wenjing.Liu@amd.com, airlied@redhat.com, Ding.Wang@amd.com,
	sylvia.tsai@amd.com, hersenxs.wu@amd.com, Rex.Zhu@amd.com,
	JinHuiEric.Huang@amd.com, dan.carpenter@oracle.com,
	architt@codeaurora.org, daniel.vetter@ffwll.ch,
	narmstrong@baylibre.com, ville.syrjala@linux.intel.com,
	jcrouse@codeaurora.org, aishpant@gmail.com, noralf@tronnes.org,
	andresx7@gmail.com, Monk.Liu@amd.com, nicolai.haehnle@amd.com,
	Andrey.Grodzovsky@amd.com, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	linux-raid@vger.kernel.org
Subject: [PATCH] fix double ;;s in code
Message-ID: <20180217211955.GE9640@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
List-ID: <linux-block@vger.kernel.org>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Fix double ;;'s in code.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 9d27331..ec12fe1 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu =3D &cpuinfo_arc700[smp_processor_id()];
 	int saved =3D 0, present =3D 0;
-	char *opt_nm =3D NULL;;
+	char *opt_nm =3D NULL;
=20
 	if (!cpu->extn.timer0)
 		panic("Timer0 is not present!\n");
diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 333daab..183391d 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
 	return;
=20
 ret_err:
-	panic("Attention !!! Dwarf FDE parsing errors\n");;
+	panic("Attention !!! Dwarf FDE parsing errors\n");
 }
=20
 #ifdef CONFIG_MODULES
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 629f8e9..cf2701c 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,7 +83,7 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
=20
 static clock_access_fn __read_persistent_clock =3D dummy_clock_access;
-static clock_access_fn __read_boot_clock =3D dummy_clock_access;;
+static clock_access_fn __read_boot_clock =3D dummy_clock_access;
=20
 void read_persistent_clock64(struct timespec64 *ts)
 {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6618036..9ae31f7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1419,7 +1419,7 @@ static int compat_ptrace_hbp_get(unsigned int note_ty=
pe,
 	u64 addr =3D 0;
 	u32 ctrl =3D 0;
=20
-	int err, idx =3D compat_ptrace_hbp_num_to_idx(num);;
+	int err, idx =3D compat_ptrace_hbp_num_to_idx(num);
=20
 	if (num & 1) {
 		err =3D ptrace_hbp_get_addr(note_type, tsk, idx, &addr);
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f0f5cd4..f9818d7 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -188,7 +188,7 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, =
u8 prio)
 	if (!qpage) {
 		pr_err("Failed to allocate queue %d for VCPU %d\n",
 		       prio, xc->server_num);
-		return -ENOMEM;;
+		return -ENOMEM;
 	}
 	memset(qpage, 0, 1 << xive->q_order);
=20
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index 496e476..a6c92c7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1854,7 +1854,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *=
pdev, u64 dma_mask)
 	s64 rc;
=20
 	if (WARN_ON(!pdn || pdn->pe_number =3D=3D IODA_INVALID_PE))
-		return -ENODEV;;
+		return -ENODEV;
=20
 	pe =3D &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eb=
oot.c
index 353e20c..886a911 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -439,7 +439,7 @@ setup_uga32(void **uga_handle, unsigned long size, u32 =
*width, u32 *height)
 	struct efi_uga_draw_protocol *uga =3D NULL, *first_uga;
 	efi_guid_t uga_proto =3D EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u32 *handles =3D (u32 *)uga_handle;;
+	u32 *handles =3D (u32 *)uga_handle;
 	efi_status_t status =3D EFI_INVALID_PARAMETER;
 	int i;
=20
@@ -484,7 +484,7 @@ setup_uga64(void **uga_handle, unsigned long size, u32 =
*width, u32 *height)
 	struct efi_uga_draw_protocol *uga =3D NULL, *first_uga;
 	efi_guid_t uga_proto =3D EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u64 *handles =3D (u64 *)uga_handle;;
+	u64 *handles =3D (u64 *)uga_handle;
 	efi_status_t status =3D EFI_INVALID_PARAMETER;
 	int i;
=20
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9ed51d0c..e4929ee 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -490,7 +490,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
=20
 	if (!found_com_id) {
 		pr_debug("Could not find OPAL comid for device. Returning early\n");
-		return -EOPNOTSUPP;;
+		return -EOPNOTSUPP;
 	}
=20
 	dev->comid =3D comid;
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mip=
s-gic-timer.c
index a04808a..65e18c8 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -205,12 +205,12 @@ static int __init gic_clocksource_of_init(struct devi=
ce_node *node)
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
 		pr_err("GIC frequency not specified.\n");
-		return -EINVAL;;
+		return -EINVAL;
 	}
 	gic_timer_irq =3D irq_of_parse_and_map(node, 0);
 	if (!gic_timer_irq) {
 		pr_err("GIC timer IRQ not specified.\n");
-		return -EINVAL;;
+		return -EINVAL;
 	}
=20
 	ret =3D __gic_clocksource_init();
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-=
sun5i.c
index 2a3fe83..3b56ea3 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -334,7 +334,7 @@ static int __init sun5i_timer_init(struct device_node *=
node)
 	timer_base =3D of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(timer_base)) {
 		pr_err("Can't map registers\n");
-		return PTR_ERR(timer_base);;
+		return PTR_ERR(timer_base);
 	}
=20
 	irq =3D irq_of_parse_and_map(node, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 61e8c3e..33d91e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -718,7 +718,7 @@ static enum link_training_result perform_channel_equali=
zation_sequence(
 	uint32_t retries_ch_eq;
 	enum dc_lane_count lane_count =3D lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated =3D {{0}};
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};;
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};
=20
 	hw_tr_pattern =3D get_supported_tp(link);
=20
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 4c3223a..adb6e7b 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
 		if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
 			pr_err("smc start failed\n");
 			hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
-			return -EINVAL;;
+			return -EINVAL;
 		}
 		if (ret =3D=3D PP_DPM_DISABLED)
 			goto exit;
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/=
mdp/mdp5/mdp5_kms.c
index 3e9bba4..6d8e3a9 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -680,7 +680,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 	} else {
 		dev_info(&pdev->dev,
 			 "no iommu, fallback to phys contig buffers for scanout\n");
-		aspace =3D NULL;;
+		aspace =3D NULL;
 	}
=20
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/sc=
heduler/gpu_scheduler.c
index 2c18996..0d95888 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
@@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_scheduler *s=
ched, struct drm_sched_jo
 {
 	struct drm_sched_job *s_job;
 	struct drm_sched_entity *entity, *tmp;
-	int i;;
+	int i;
=20
 	spin_lock(&sched->job_list_lock);
 	list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 35a408d..99bc9bd 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -205,7 +205,7 @@ static void intel_flush_svm_range_dev (struct intel_svm=
 *svm, struct intel_svm_d
 			 * for example, an "address" value of 0x12345f000 will
 			 * flush from 0x123440000 to 0x12347ffff (256KiB). */
 			unsigned long last =3D address + ((unsigned long)(pages - 1) << VTD_PAG=
E_SHIFT);
-			unsigned long mask =3D __rounddown_pow_of_two(address ^ last);;
+			unsigned long mask =3D __rounddown_pow_of_two(address ^ last);
=20
 			desc.high =3D QI_DEV_EIOTLB_ADDR((address & ~mask) | (mask - 1)) | QI_D=
EV_EIOTLB_SIZE;
 		} else {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index b2eae33..f978edd 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1108,7 +1108,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_=
bio,
=20
 	bio_copy_data(behind_bio, bio);
 skip_copy:
-	r1_bio->behind_master_bio =3D behind_bio;;
+	r1_bio->behind_master_bio =3D behind_bio;
 	set_bit(R1BIO_BehindIO, &r1_bio->state);
=20
 	return;
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 53f7275..cfb42f5 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -348,7 +348,7 @@ static int imx_gpc_old_dt_init(struct device *dev, stru=
ct regmap *regmap,
 		if (i =3D=3D 1) {
 			domain->supply =3D devm_regulator_get(dev, "pu");
 			if (IS_ERR(domain->supply))
-				return PTR_ERR(domain->supply);;
+				return PTR_ERR(domain->supply);
=20
 			ret =3D imx_pgc_get_clocks(dev, domain);
 			if (ret)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqInHsACgkQMOfwapXb+vLWpQCfc25IPEpQUJuHLZa7oUs8dmSm
YeUAnApvTpd87CjFr/u4YNLTXhirl6q/
=bR9a
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

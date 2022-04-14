Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A24EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 01:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiDNBFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiDNBFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 21:05:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EBA51E4F
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Q+WgBtUMrXSczX4yNe3a1Nik3x+uj8otwgOMd3+iPgQ=; b=V9W0BG+qEqpasEnsihUkXcFA9j
        ofafVM5M0CH3mkILerToUBzk6T2xgOPiOJV13yNM9UNX7JUvoBdhJIwdSgtPIb/2oqjq4LjsV7kms
        oS7pOiLE8aWLoFjeYxprkDHhXB6rBNeX9uFKw+Pfqt3Rvxvt4PoyY65ow511I2Qq8vZSuTr+P3CyM
        CfbAU9yn/4nW5pEJSb45SkQqX49stq80YK92VtTvS4+N+Ja+m/JAS3LIDPyzFApKMM+TOJxRQmP/5
        CcnMczxLOslO+H0C7JlQ9+NvsCbp6amUemHoyZ2L4Ol4+SulJ9NZrzBb+oN3zpDst/O5VLQsmQ6+w
        GF6o1gyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nent5-003EU2-2D; Thu, 14 Apr 2022 01:03:07 +0000
Date:   Wed, 13 Apr 2022 18:03:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Subject: Re: blktests srp failures with a guest with kdevops on v5.17-rc7
 removal
Message-ID: <Yldyy3ZSEbaTxwSj@bombadil.infradead.org>
References: <YldoSh6o5sbifsJf@bombadil.infradead.org>
 <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 05:50:38PM -0700, Bart Van Assche wrote:
> On 4/13/22 17:18, Luis Chamberlain wrote:
> > I've started to work on expanding coverage of testing with blktests
> > on kdevops [0] to other test groups. srp was one of them. But the amount
> > of failures I'm seeing seems to tell me I'm probably doing something
> > really stupid, so please help me review the setup. The baseline for
> > srp is listed below, each of these is a failure. I've used v5.17-rc7
> > as a starting point.
>=20
> Do the SRP tests pass when using the Soft-iWARP driver instead of rdma_rx=
e?

It looks *much* better.

> I'm asking this because there are known issues with the rdma_rxe driver in
> kernel versions v5.17 and also in v5.18-rc1.

OK thanks.

> An example of how to select the
> Soft-iWARP driver:
>=20
> cd blktests && use_siw=3D1 ./check -q srp/001

I see failures on the first run:

srp/005
srp/011
srp/013

I'll run this in a tight loop but so far at least no crashes...
On the second run I see srp/001 producing the warning attached
at the end of this email.

--- tests/srp/005.out       2022-04-09 03:14:48.859579024 +0000
+++ /usr/local/blktests/results/nodev/srp/005.out.bad
2022-04-14 00:56:22.720369781 +0000
@@ -1,2 +1 @@
Configured SRP target driver
-Passed

srp/011 (Block I/O on top of multipath concurrently with logout and login) =
[failed]
runtime    ...  10.180s
--- tests/srp/011.out       2022-04-09 03:14:48.859579024 +0000
+++ /usr/local/blktests/results/nodev/srp/011.out.bad
2022-04-14 00:58:03.008417505 +0000
@@ -1,2 +1 @@
Configured SRP target driver
-Passed

srp/013 (Direct I/O using a discontiguous buffer)            [failed]
runtime    ...  9.828s
--- tests/srp/013.out       2022-04-09 03:14:48.859579024 +0000
+++ /usr/local/blktests/results/nodev/srp/013.out.bad
2022-04-14 00:58:25.600409775 +0000
@@ -1,7 +1 @@
Configured SRP target driver
-Reading first 512 bytes with dd
-Number of bytes read: 512
-Writing data ^ 0xa5 ...
-Rereading data with dd ...
-Rereading data with discontiguous-io ...
-Passed

[  380.503111] run blktests srp/001 at 2022-04-14 01:00:47
[  380.865649] null_blk: module loaded
[  380.999005] SoftiWARP attached
[  381.019047] eth0 speed is unknown, defaulting to 1000
[  381.023560] eth0 speed is unknown, defaulting to 1000
[  381.030457] eth0 speed is unknown, defaulting to 1000
[  381.052554] eth0 speed is unknown, defaulting to 1000
[  381.061983] eth1 speed is unknown, defaulting to 1000
[  381.067453] eth1 speed is unknown, defaulting to 1000
[  381.070008] eth1 speed is unknown, defaulting to 1000
[  381.087796] device-mapper: table: 253:3: multipath: error getting device=
 (-EBUSY)
[  381.089674] device-mapper: ioctl: error adding target to table
[  381.100498] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.102506] device-mapper: core: Cannot calculate initial queue limits
[  381.104151] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.111628] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.113944] device-mapper: core: Cannot calculate initial queue limits
[  381.115645] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.122216] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.123597] device-mapper: core: Cannot calculate initial queue limits
[  381.124875] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.130155] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.131517] device-mapper: core: Cannot calculate initial queue limits
[  381.132812] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.138748] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.140521] device-mapper: core: Cannot calculate initial queue limits
[  381.141656] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.147756] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.149341] device-mapper: core: Cannot calculate initial queue limits
[  381.150464] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @ 00000=
000b9dfbcc5
[  381.150574] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.154977] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues=
 to 0. poll_q/nr_hw =3D (0/1)
[  381.164867] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  381.166286] scsi host2: scsi_debug: version 0190 [20200710]
                 dev_size_mb=3D32, opts=3D0x0, submit_queues=3D1, statistic=
s=3D0
[  381.169744] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.172114] device-mapper: core: Cannot calculate initial queue limits
[  381.172271] scsi 2:0:0:0: Direct-Access     Linux    scsi_debug       01=
90 PQ: 0 ANSI: 7
[  381.173709] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.178664] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.179190] sd 2:0:0:0: Power-on or device reset occurred
[  381.179394] sd 2:0:0:0: Attached scsi generic sg0 type 0
[  381.180254] device-mapper: core: Cannot calculate initial queue limits
[  381.181313] sd 2:0:0:0: [sda] Enabling DIF Type 3 protection
[  381.182268] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.184397] sd 2:0:0:0: [sda] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  381.187417] sd 2:0:0:0: [sda] Write Protect is off
[  381.188629] sd 2:0:0:0: [sda] Mode Sense: 73 00 10 08
[  381.188668] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  381.190508] sd 2:0:0:0: [sda] Optimal transfer size 524288 bytes
[  381.196135] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.197606] device-mapper: core: Cannot calculate initial queue limits
[  381.198822] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.204349] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.205840] device-mapper: core: Cannot calculate initial queue limits
[  381.207131] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.212356] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.213927] device-mapper: core: Cannot calculate initial queue limits
[  381.215264] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.220928] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.222493] device-mapper: core: Cannot calculate initial queue limits
[  381.223762] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.229311] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.231034] device-mapper: core: Cannot calculate initial queue limits
[  381.232281] sd 2:0:0:0: [sda] Enabling DIX T10-DIF-TYPE3-CRC protection
[  381.232288] sd 2:0:0:0: [sda] DIF application tag size 6
[  381.235053] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.241301] device-mapper: table: 253:3: zoned model is not consistent a=
cross all devices
[  381.242844] device-mapper: core: Cannot calculate initial queue limits
[  381.244506] device-mapper: ioctl: unable to set up device queue for new =
table.
[  381.268010] sd 2:0:0:0: [sda] Attached SCSI disk
[  381.409925] eth0 speed is unknown, defaulting to 1000
[  381.445884] eth1 speed is unknown, defaulting to 1000
[  381.494807] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[  381.516590] ib_srpt:srpt_add_one: ib_srpt device =3D 0000000032d29d7e
[  381.516676] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eth0_siw): use_sr=
q =3D 0; ret =3D 0
[  381.516679] ib_srpt:srpt_add_one: ib_srpt Target login info: id_ext=3D50=
5400fffeee1557,ioc_guid=3D505400fffeee1557,pkey=3Dffff,service_id=3D505400f=
ffeee1557
[  381.516691] eth0 speed is unknown, defaulting to 1000
[  381.518574] ib_srpt:srpt_add_one: ib_srpt added eth0_siw.
[  381.518580] ib_srpt:srpt_add_one: ib_srpt device =3D 00000000218d85a4
[  381.518623] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eth1_siw): use_sr=
q =3D 0; ret =3D 0
[  381.518626] ib_srpt:srpt_add_one: ib_srpt Target login info: id_ext=3D50=
5400fffeee1557,ioc_guid=3D505400fffeee1557,pkey=3Dffff,service_id=3D505400f=
ffeee1557
[  381.518630] eth1 speed is unknown, defaulting to 1000
[  381.519852] ib_srpt:srpt_add_one: ib_srpt added eth1_siw.
[  381.767210] Rounding down aligned max_sectors from 255 to 248
[  381.799282] Rounding down aligned max_sectors from 255 to 248
[  381.830877] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[  381.838815] iwpm_register_pid: Unable to send a nlmsg (client =3D 2)
[  382.458775] ib_srp:srp_add_one: ib_srp: srp_add_one: 1844674407370955161=
5 / 4096 =3D 4503599627370495 <> 512
[  382.458782] ib_srp:srp_add_one: ib_srp: eth0_siw: mr_page_shift =3D 12, =
device->max_mr_size =3D 0xffffffffffffffff, device->max_fast_reg_page_list_=
len =3D 256, max_pages_per_mr =3D 256, mr_max_size =3D 0x100000
[  382.458996] ib_srp:srp_add_one: ib_srp: srp_add_one: 1844674407370955161=
5 / 4096 =3D 4503599627370495 <> 512
[  382.458999] ib_srp:srp_add_one: ib_srp: eth1_siw: mr_page_shift =3D 12, =
device->max_mr_size =3D 0xffffffffffffffff, device->max_fast_reg_page_list_=
len =3D 256, max_pages_per_mr =3D 256, mr_max_size =3D 0x100000
[  382.477094] eth0 speed is unknown, defaulting to 1000
[  382.525606] ib_srp:srp_parse_in: ib_srp: 192.168.121.131 -> 192.168.121.=
131:0
[  382.525623] ib_srp:srp_parse_in: ib_srp: 192.168.121.131:5555 -> 192.168=
=2E121.131:5555
[  382.525627] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 256; mr_page_size =3D 4096; max_sectors_per_mr =3D 2048; mr=
_per_cmd =3D 2
[  382.525631] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.530505] scsi host3: ib_srp: REJ received
[  382.530509] scsi host3:   REJ reason 0xffffff98
[  382.532254] scsi host3: ib_srp: Connection 0/8 to 192.168.121.131 failed
[  382.657895] ib_srp:srp_parse_in: ib_srp: 192.168.121.131 -> 192.168.121.=
131:0
[  382.657912] ib_srp:srp_parse_in: ib_srp: 192.168.121.131:5555 -> 192.168=
=2E121.131:5555
[  382.657926] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:feee:1557%2] -> =
[fe80::5054:ff:feee:1557]:0/11041155%2
[  382.657935] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:feee:1557%2]:555=
5 -> [fe80::5054:ff:feee:1557]:5555/11041155%2
[  382.657938] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 256; mr_page_size =3D 4096; max_sectors_per_mr =3D 2048; mr=
_per_cmd =3D 2
[  382.657941] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.660937] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:00ee:1557=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:00ee:1557:0000:0000:0000:0000:0=
000); pkey 0x00
[  382.665498] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  382.710326] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 0000000097c9cb1e
[  382.710360] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:feee:1557 or i_port_id 0x525400ee15570000000000000=
0000000
[  382.710478] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000003cb803cc name=3Dfe80:0000:0000:0000:5054:00ff:feee:1557 ch=3D000=
0000097c9cb1e
[  382.710690] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:feee:1557-2: queued zerolength write
[  382.710798] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.710806] scsi host3: ib_srp: using immediate data
[  382.710925] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:feee:1557-2 wc->status 0
[  382.716625] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:00ee:1557=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:00ee:1557:0000:0000:0000:0000:0=
000); pkey 0x00
[  382.722659] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  382.767729] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 00000000ec091c66
[  382.767764] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:feee:1557 or i_port_id 0x525400ee15570000000000000=
0000000
[  382.767931] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000bff2da7c name=3Dfe80:0000:0000:0000:5054:00ff:feee:1557 ch=3D000=
00000ec091c66
[  382.768105] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:feee:1557-4: queued zerolength write
[  382.768151] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.768157] scsi host3: ib_srp: using immediate data
[  382.768264] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:feee:1557-4 wc->status 0
[  382.774780] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:00ee:1557=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:00ee:1557:0000:0000:0000:0000:0=
000); pkey 0x00
[  382.782355] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  382.834213] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 0000000013ca2fb0
[  382.834250] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:feee:1557 or i_port_id 0x525400ee15570000000000000=
0000000
[  382.834349] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000116a3c16 name=3Dfe80:0000:0000:0000:5054:00ff:feee:1557 ch=3D000=
0000013ca2fb0
[  382.834556] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:feee:1557-6: queued zerolength write
[  382.834616] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:feee:1557-6 wc->status 0
[  382.834641] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.834648] scsi host3: ib_srp: using immediate data
[  382.839858] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:00ee:1557=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:00ee:1557:0000:0000:0000:0000:0=
000); pkey 0x00
[  382.844633] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  382.887857] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 00000000e2c5d5b4
[  382.887895] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:feee:1557 or i_port_id 0x525400ee15570000000000000=
0000000
[  382.887989] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000e86dc202 name=3Dfe80:0000:0000:0000:5054:00ff:feee:1557 ch=3D000=
00000e2c5d5b4
[  382.888221] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:feee:1557-8: queued zerolength write
[  382.888356] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  382.888364] scsi host3: ib_srp: using immediate data
[  382.888390] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:feee:1557-8 wc->status 0
[  382.894820] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:00ee:1557=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:00ee:1557:0000:0000:0000:0000:0=
000); pkey 0x00
[  382.901183] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  382.951022] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 000000004085ab49
[  382.951054] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:feee:1557 or i_port_id 0x525400ee15570000000000000=
0000000
[  382.951150] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000000cbc2f7f name=3Dfe80:0000:0000:0000:5054:00ff:feee:1557 ch=3D000=
000004085ab49
[  382.951345] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:feee:1557-10: queued zerolength write
[  382.951500] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:feee:1557-10 wc->status 0
[  382.951564] scsi host3: ib_srp: Sending CM REQ failed
[  382.951613] scsi host3: ib_srp: Connection 4/8 to fe80:0000:0000:0000:50=
54:00ff:feee:1557 failed
[  382.951662] ib_srpt receiving failed for ioctx 00000000e9759aa2 with sta=
tus 5
[  382.956507] ib_srpt receiving failed for ioctx 000000006a2e1f85 with sta=
tus 5
[  382.958585] ib_srpt receiving failed for ioctx 000000006e2ef287 with sta=
tus 5
[  382.960616] ib_srpt receiving failed for ioctx 0000000070a243da with sta=
tus 5
[  382.962620] ib_srpt receiving failed for ioctx 00000000d4c07f48 with sta=
tus 5
[  382.964517] ib_srpt receiving failed for ioctx 0000000055d62020 with sta=
tus 5
[  382.965816] ib_srpt receiving failed for ioctx 0000000055de8e70 with sta=
tus 5
[  382.967662] ib_srpt receiving failed for ioctx 00000000d3f5b004 with sta=
tus 5
[  382.969601] ib_srpt receiving failed for ioctx 00000000f3c78892 with sta=
tus 5
[  382.971506] ib_srpt receiving failed for ioctx 00000000bcad34b5 with sta=
tus 5
[  383.055953] scsi host3: SRP.T10:505400FFFEEE1557
[  383.063190] scsi 3:0:0:0: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.066315] scsi 3:0:0:0: alua: supports implicit and explicit TPGS
[  383.068034] scsi 3:0:0:0: alua: device naa.60014056e756c6c62300000000000=
000 port group 0 rel port 1
[  383.071048] sd 3:0:0:0: Attached scsi generic sg1 type 0
[  383.073267] sd 3:0:0:0: Warning! Received an indication that the LUN ass=
ignments on this target have changed. The Linux SCSI layer does not automat=
ical
[  383.080156] sd 3:0:0:0: alua: transition timeout set to 60 seconds
[  383.081497] sd 3:0:0:0: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  383.083887] sd 3:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.085481] scsi 3:0:0:2: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.087444] sd 3:0:0:0: [sdb] Write Protect is off
[  383.088857] sd 3:0:0:0: [sdb] Mode Sense: 43 00 00 08
[  383.089287] sd 3:0:0:0: [sdb] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  383.089384] scsi 3:0:0:2: alua: supports implicit and explicit TPGS
[  383.092218] scsi 3:0:0:2: alua: device naa.60014057363736964626700000000=
000 port group 0 rel port 1
[  383.093400] sd 3:0:0:0: [sdb] Optimal transfer size 126976 bytes
[  383.095055] sd 3:0:0:2: Attached scsi generic sg2 type 0
[  383.095084] sd 3:0:0:2: [sdc] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.098829] sd 3:0:0:2: [sdc] Write Protect is off
[  383.101105] sd 3:0:0:2: [sdc] Mode Sense: 43 00 10 08
[  383.101324] scsi 3:0:0:1: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.103398] sd 3:0:0:2: [sdc] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  383.106844] scsi 3:0:0:1: alua: supports implicit and explicit TPGS
[  383.106886] sd 3:0:0:2: [sdc] Optimal transfer size 524288 bytes
[  383.108208] scsi 3:0:0:1: alua: device naa.60014056e756c6c62310000000000=
000 port group 0 rel port 1
[  383.112310] sd 3:0:0:1: Attached scsi generic sg3 type 0
[  383.112331] sd 3:0:0:2: alua: transition timeout set to 60 seconds
[  383.112711] sd 3:0:0:1: Warning! Received an indication that the LUN ass=
ignments on this target have changed. The Linux SCSI layer does not automat=
ical
[  383.114167] ib_srp:srp_add_target: ib_srp: host3: SCSI scan succeeded - =
detected 3 LUNs
[  383.114503] sd 3:0:0:2: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  383.118240] scsi host3: ib_srp: new target: id_ext 505400fffeee1557 ioc_=
guid 505400fffeee1557 sgid 5254:00ee:1557:0000:0000:0000:0000:0000 dest fe8=
0:0000:0000:0000:5054:00ff:feee:1557
[  383.124086] sd 3:0:0:1: alua: transition timeout set to 60 seconds
[  383.126081] sd 3:0:0:1: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  383.129592] sd 3:0:0:1: [sdd] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.132072] sd 3:0:0:1: [sdd] Write Protect is off
[  383.133604] sd 3:0:0:1: [sdd] Mode Sense: 43 00 00 08
[  383.133954] sd 3:0:0:1: [sdd] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  383.138162] sd 3:0:0:1: [sdd] Optimal transfer size 126976 bytes
[  383.142383] eth1 speed is unknown, defaulting to 1000
[  383.173520] sd 3:0:0:0: [sdb] Attached SCSI disk
[  383.174941] ib_srp:srp_parse_in: ib_srp: 172.17.8.113 -> 172.17.8.113:0
[  383.175006] ib_srp:srp_parse_in: ib_srp: 172.17.8.113:5555 -> 172.17.8.1=
13:5555
[  383.175010] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 256; mr_page_size =3D 4096; max_sectors_per_mr =3D 2048; mr=
_per_cmd =3D 2
[  383.175013] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.179926] ------------[ cut here ]------------
[  383.180984] WARNING: CPU: 0 PID: 199 at drivers/infiniband/sw/siw/siw_cm=
=2Ec:255 siw_cep_put+0x125/0x130 [siw]
[  383.182649] Modules linked in: ib_srp(E) scsi_transport_srp(E) target_co=
re_pscsi(E) target_core_file(E) ib_srpt(E) target_core_iblock(E) target_cor=
e_mod(E) rdma_cm(E) iw_cm(E) ib_cm(E) scsi_debug(E) siw(E) null_blk(E) ib_u=
mad(E) ib_uverbs(E) sd_mod(E) sg(E) dm_service_time(E) scsi_dh_rdac(E) scsi=
_dh_emc(E) scsi_dh_alua(E) dm_multipath(E) ib_core(E) dm_mod(E) nvme_fabric=
s(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) ghash_clmulni_int=
el(E) aesni_intel(E) crypto_simd(E) cryptd(E) cirrus(E) drm_shmem_helper(E)=
 evdev(E) joydev(E) serio_raw(E) drm_kms_helper(E) virtio_balloon(E) cec(E)=
 i6300esb(E) button(E) drm(E) configfs(E) ip_tables(E) x_tables(E) autofs4(=
E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) xor(E) r=
aid6_pq(E) zstd_compress(E) libcrc32c(E) crc32c_generic(E) virtio_net(E) ne=
t_failover(E) failover(E) virtio_blk(E) ata_generic(E) uhci_hcd(E) ata_piix=
(E) crc32_pclmul(E) crc32c_intel(E) psmouse(E) nvme(E) ehci_hcd(E) libata(E=
) nvme_core(E) usbcore(E)
[  383.182727]  scsi_mod(E)
[  383.188759] sd 3:0:0:2: [sdc] Attached SCSI disk
[  383.197156]  virtio_pci(E) t10_pi(E) virtio_pci_legacy_dev(E) virtio_pci=
_modern_dev(E) virtio(E) virtio_ring(E) i2c_piix4(E) usb_common(E) scsi_com=
mon(E) [last unloaded: null_blk]
[  383.202853] CPU: 5 PID: 199 Comm: kworker/u16:26 Kdump: loaded Tainted: =
G            E     5.17.0-rc7 #1
[  383.205154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.15.0-1 04/01/2014
[  383.206940] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[  383.208370] RIP: 0010:siw_cep_put+0x125/0x130 [siw]
[  383.209743] Code: a8 c0 e8 ae 24 e3 d2 48 89 ef 5d 41 5c 41 5d e9 b1 86 =
c3 d2 5d be 03 00 00 00 41 5c 41 5d e9 22 67 e0 d2 0f 0b e9 f3 fe ff ff <0f=
> 0b e9 1c ff ff ff 0f 1f 40 00 0f 1f 44 00 00 55 48 8d 6f 20 53
[  383.213040] RSP: 0018:ffffad17c04b7c98 EFLAGS: 00010286
[  383.213056] sd 3:0:0:1: [sdd] Attached SCSI disk
[  383.214651] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000000=
00000
[  383.217117] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff988e0d4=
30424
[  383.218958] RBP: ffff988e0d430400 R08: ffff988e0d430420 R09: ffffad17c04=
b7c50
[  383.220916] R10: 00000000000000cc R11: 0000000000000070 R12: ffff988e73d=
6f000
[  383.222753] R13: ffff988e51c016a0 R14: ffff988e51c01678 R15: ffff988e0a0=
3c358
[  383.225137] FS:  0000000000000000(0000) GS:ffff988f37c40000(0000) knlGS:=
0000000000000000
[  383.227840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  383.229250] CR2: 00007f24e0757390 CR3: 00000001a340a002 CR4: 00000000007=
70ee0
[  383.230514] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  383.232715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  383.235245] PKRU: 55555554
[  383.236270] Call Trace:
[  383.237126]  <TASK>
[  383.237882]  siw_reject+0xac/0x180 [siw]
[  383.238887]  iw_cm_reject+0x68/0xc0 [iw_cm]
[  383.240126]  cm_work_handler+0x59d/0xe20 [iw_cm]
[  383.241788]  process_one_work+0x1e2/0x3b0
[  383.243865]  worker_thread+0x50/0x3a0
[  383.245203]  ? rescuer_thread+0x390/0x390
[  383.246407]  kthread+0xe5/0x110
[  383.247493]  ? kthread_complete_and_exit+0x20/0x20
[  383.248771]  ret_from_fork+0x1f/0x30
[  383.250097]  </TASK>
[  383.251316] ---[ end trace 0000000000000000 ]---
[  383.252986] scsi host4: ib_srp: REJ received
[  383.252988] scsi host4:   REJ reason 0xffffff98
[  383.254207] scsi host4: ib_srp: Connection 0/8 to 172.17.8.113 failed
[  383.396184] ib_srp:srp_parse_in: ib_srp: 172.17.8.113 -> 172.17.8.113:0
[  383.396212] ib_srp:srp_parse_in: ib_srp: 172.17.8.113:5555 -> 172.17.8.1=
13:5555
[  383.396251] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe5b:90dc%3] -> =
[fe80::5054:ff:fe5b:90dc]:0/202442865%3
[  383.396272] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe5b:90dc%3]:555=
5 -> [fe80::5054:ff:fe5b:90dc]:5555/202442865%3
[  383.396282] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 256; mr_page_size =3D 4096; max_sectors_per_mr =3D 2048; mr=
_per_cmd =3D 2
[  383.396288] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.401391] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.406794] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.454975] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 0000000070390072
[  383.455011] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.455111] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000ac164cc9 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
0000070390072
[  383.455335] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-2: queued zerolength write
[  383.455378] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-2 wc->status 0
[  383.455385] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.455389] scsi host4: ib_srp: using immediate data
[  383.462884] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.467599] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.545587] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 0000000083d40259
[  383.545691] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.545944] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000001e808f49 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
0000083d40259
[  383.546426] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-4: queued zerolength write
[  383.546762] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.546773] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-4 wc->status 0
[  383.546795] scsi host4: ib_srp: using immediate data
[  383.555617] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.568710] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.616300] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 000000005aea2d99
[  383.616340] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.616453] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000876fc647 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
000005aea2d99
[  383.616762] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.616768] scsi host4: ib_srp: using immediate data
[  383.620254] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-6: queued zerolength write
[  383.620493] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-6 wc->status 0
[  383.623186] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.628939] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.671948] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 00000000cac8081d
[  383.671987] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.672109] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000a0de6cf7 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
00000cac8081d
[  383.672332] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-8: queued zerolength write
[  383.672463] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.672471] scsi host4: ib_srp: using immediate data
[  383.672901] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-8 wc->status 0
[  383.677264] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.680811] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.716730] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 0000000081e8c03c
[  383.716775] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.716904] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000fcc88a24 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
0000081e8c03c
[  383.717106] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-10: queued zerolength write
[  383.717299] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-10 wc->status 0
[  383.717361] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.717371] scsi host4: ib_srp: using immediate data
[  383.723473] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.729761] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.773088] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 00000000f7ba0d87
[  383.773130] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.773260] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000b40cb625 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
00000f7ba0d87
[  383.773507] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-12: queued zerolength write
[  383.773599] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-12 wc->status 0
[  383.773702] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.773707] scsi host4: ib_srp: using immediate data
[  383.779488] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.785095] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.825332] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 00000000f6ee77e6
[  383.825365] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.825465] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000009e823d9a name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
00000f6ee77e6
[  383.825667] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-14: queued zerolength write
[  383.825761] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.825768] scsi host4: ib_srp: using immediate data
[  383.825839] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-14 wc->status 0
[  383.830885] ib_srpt Received SRP_LOGIN_REQ with i_port_id 5254:005b:90dc=
:0000:0000:0000:0000:0000, t_port_id 5054:00ff:feee:1557:5054:00ff:feee:155=
7 and it_iu_len 8260 on port 1 (guid=3D5254:005b:90dc:0000:0000:0000:0000:0=
000); pkey 0x00
[  383.837915] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  383.878318] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8192 max_sge=3D 6 sq_size =3D 8192 ch=3D 000000002a42fc92
[  383.878357] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr fe80:=
0000:0000:0000:5054:00ff:fe5b:90dc or i_port_id 0x5254005b90dc0000000000000=
0000000
[  383.878506] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000edf9a0b5 name=3Dfe80:0000:0000:0000:5054:00ff:fe5b:90dc ch=3D000=
000002a42fc92
[  383.878811] ib_srpt:srpt_zerolength_write: ib_srpt fe80:0000:0000:0000:5=
054:00ff:fe5b:90dc-16: queued zerolength write
[  383.879094] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  383.879100] scsi host4: ib_srp: using immediate data
[  383.879118] ib_srpt:srpt_zerolength_write_done: ib_srpt fe80:0000:0000:0=
000:5054:00ff:fe5b:90dc-16 wc->status 0
[  383.880559] scsi host4: SRP.T10:505400FFFEEE1557
[  383.894566] scsi 4:0:0:0: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.897146] scsi 4:0:0:0: alua: supports implicit and explicit TPGS
[  383.898284] scsi 4:0:0:0: alua: device naa.60014056e756c6c62300000000000=
000 port group 0 rel port 2
[  383.901450] scsi 4:0:0:0: Attached scsi generic sg4 type 0
[  383.907330] sd 4:0:0:0: Warning! Received an indication that the LUN ass=
ignments on this target have changed. The Linux SCSI layer does not automat=
ical
[  383.909871] scsi 4:0:0:2: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.912742] scsi 4:0:0:2: alua: supports implicit and explicit TPGS
[  383.914034] scsi 4:0:0:2: alua: device naa.60014057363736964626700000000=
000 port group 0 rel port 2
[  383.917412] sd 4:0:0:2: Attached scsi generic sg5 type 0
[  383.921565] sd 4:0:0:2: [sdf] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.922075] scsi 4:0:0:1: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  383.923442] sd 4:0:0:0: [sde] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.923854] sd 4:0:0:0: [sde] Write Protect is off
[  383.923872] sd 4:0:0:0: [sde] Mode Sense: 43 00 00 08
[  383.924445] sd 4:0:0:0: [sde] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  383.924894] sd 4:0:0:0: [sde] Optimal transfer size 126976 bytes
[  383.928205] sd 4:0:0:2: [sdf] Write Protect is off
[  383.931129] scsi 4:0:0:1: alua: supports implicit and explicit TPGS
[  383.934324] sd 4:0:0:2: [sdf] Mode Sense: 43 00 10 08
[  383.934951] scsi 4:0:0:1: alua: device naa.60014056e756c6c62310000000000=
000 port group 0 rel port 2
[  383.942840] sd 4:0:0:2: [sdf] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  383.944561] sd 4:0:0:1: Warning! Received an indication that the LUN ass=
ignments on this target have changed. The Linux SCSI layer does not automat=
ical
[  383.947858] sd 4:0:0:2: [sdf] Optimal transfer size 524288 bytes
[  383.948754] sd 4:0:0:1: Attached scsi generic sg6 type 0
[  383.950365] ib_srp:srp_add_target: ib_srp: host4: SCSI scan succeeded - =
detected 3 LUNs
[  383.955374] scsi host4: ib_srp: new target: id_ext 505400fffeee1557 ioc_=
guid 505400fffeee1557 sgid 5254:005b:90dc:0000:0000:0000:0000:0000 dest fe8=
0:0000:0000:0000:5054:00ff:fe5b:90dc
[  383.961311] sd 4:0:0:1: [sdg] 65536 512-byte logical blocks: (33.6 MB/32=
=2E0 MiB)
[  383.964320] sd 4:0:0:1: [sdg] Write Protect is off
[  383.967203] sd 4:0:0:1: [sdg] Mode Sense: 43 00 00 08
[  383.967855] sd 4:0:0:1: [sdg] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  383.972415] sd 4:0:0:1: [sdg] Optimal transfer size 126976 bytes

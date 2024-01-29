Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C95FDB2
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529468; cv=fail; b=Ruhhf2s+9TEzYJzZecgU5LnMY2v/3Z83tbhOxDqUc7eY3QYzg8ZH2yCDw/h94y7VtP9aDktDxfzx2sX0cGh+sgha9B2GwYvbayZ1erb0astD0/DxaTcdSFHcOZILttmDYlLrTNexKWkI3ocZf7LYsUytN3Cbh+xGdZUsIfmB8EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529468; c=relaxed/simple;
	bh=Z4SWqO/QO2/ZGdWeiW8l/GeNxKM8G/80Zj1PH611kb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWC8Cy/jY1zsqTmU2PQ3d+ZQ8WXmRkgs3jT5GtrnmD6+CniO4MMziC/f5b7oQmfnROKgOHD9dfYi2ATRO2j96HziJCoAUUFoq2h6WqZK1K5hf8CAyvL0Q/lhp1wWpneGAwAiGccNbAv7u6yqCvVIr+5+Wj41P0cY1CWe/KjJgoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mlDBaFhi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BGEvoJoR; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mlDBaFhi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BGEvoJoR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706529465; x=1738065465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z4SWqO/QO2/ZGdWeiW8l/GeNxKM8G/80Zj1PH611kb4=;
  b=mlDBaFhiTgX5/L3hp9UYdzWYNpStEVgxDstuFypDHQSn1fSKaTGaqFTo
   b/NI0QBpjVWekO9OhDxdVaDkSP7uBtSRApwWZ+gEfFiVpkKJJa5yTkFLB
   f4ett5YrzF9fWuzvYPkK10B37zQxWNUEX+CwDDBrz+pRXO52E7cL8t5ak
   RPFzyJCXrsfE5dbldyGajgT4KZp0E1+Wg0o+t9CBynGowz3w7moBOdnY/
   Dpi/5PIXq4JjiOkrzwWYgYPQlbe4MM9acgpKMpaULAOrmKdSFcIx6lRWT
   1tf9xGQvSMo848pjV8OAH55ajWn60Ce+vHVia9tBdXdmDneYML0iJW3Aa
   A==;
X-CSE-ConnectionGUID: 8NAj5q+ETeqhAjWXpYdQEQ==
X-CSE-MsgGUID: PfoH1cUcSTy50JlOc0MeLw==
X-IronPort-AV: E=Sophos;i="6.05,227,1701100800"; 
   d="scan'208";a="7972774"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 19:57:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2YQisi8opnTj8Ll+zZUIp2mYxZ5pYuqrp0pTOM4nUbKt6Iq6cqjWVw8cli1EqrluKbFvl/q0kMuT8UjETJaBBE1DPdgydC/wFP685Uwk5ONK8QlZEKLvnyrTw10VzhbBucdlrCCGOR7sonnLwHGEiM3r9pXK8elbrbg8VW8rgWqvoLeHYVqllwzrYkBiVEyY51GTQbeIY/r9E45en34BFME/Cg82sDnD2LeUTlexcplbG7rKFr9E7cKfF4l/+BqbCb5P1eKxJOucfoMAzJLfrrSq5T6bXD6YljsrZe3Rk+hfamxH7wnZD7pWJpalnqGczxP8XAt9TpQTc8mrZGwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d1mI+2rwCdIw9+nETzXCGOL/PdD7U3LeIkfJ3SPZgc=;
 b=TGyOdJmKJQJI4c1eF5cQnQTxITlTmHfrGN3gXmMATVRWtnAQNMozAOctAyHBAnGPQlh9qkJCgi4yYVuf9ST5XZ38JwyBrxwoA6TDtIA5f/h2JSKWkiz6KFF3Hlvcai5aQ8UOLgUT5GzdnHbEv5AkXIJQ1Y1/DIeit1T8uDyAYqpq+jlaKLtILZ/1iuVnNgDNdhqIfySvFRhC4hd+onm3gwgfnQ6qxZyeErhP8x0RW2NPc9rNTASGZmZadBYmXX+pthOG3R4dZ2aU2YcqM/r/mbVqITvVxJ1tULo/GkUejedfRjiZLUWhw72LkoVxLm2vgvpsY7X3rAjN6YYP4GaOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d1mI+2rwCdIw9+nETzXCGOL/PdD7U3LeIkfJ3SPZgc=;
 b=BGEvoJoR/APZ4rNVhAe0oCQ7gOYLPV9McW/6q59ux5pewoW/que2s6RJStFFy4mJbRmeYgUGSJ3KHzgC0Mgpxe0P4hiSTpzCQvBqGtf5d1ERpshyRmS2SHeMo5o72h6mZx4KEwxS2aSGSnzx7+nfpbPBd7WaOLAOXlkrVg//3vI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6521.namprd04.prod.outlook.com (2603:10b6:610:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.33; Mon, 29 Jan 2024 11:57:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 11:57:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests V3] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V3] nvme: add nvme pci timeout testcase
Thread-Index: AQHaTk9gWHtQE5TZs0KJeUiw48f8BLDwq+MAgAAMLYA=
Date: Mon, 29 Jan 2024 11:57:35 +0000
Message-ID: <cw6jph7xbssf2ngke7hv7uek2muonmddbbrbzd3v3a4aw66wyg@rkb4gpzgtmui>
References: <20240123225547.10221-1-kch@nvidia.com>
 <863833c7-3414-4012-a138-3d44ea44dde7@nvidia.com>
In-Reply-To: <863833c7-3414-4012-a138-3d44ea44dde7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6521:EE_
x-ms-office365-filtering-correlation-id: cd7abf1f-0426-4087-7d46-08dc20c17b73
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IFHRZbt2OgguJzvWdgHJSqtYcn7bjYeptyhymIA3sMX2bWypBqkeVZnojFbpLnTE7D2qERXHIdBmgK6lXwfy2ZSs3UvQBa2uTqw+x29DI+Y14hf1q5CM/NSMIxGcLPZ3jnfiBGsOsOjrygibmFGTMVEYd34J5pPNIcYqKWmyJnVRrLoywEO36BdnLA/jGjVEyd+jq3yupVps+IvvM9BbAlGx5816khKgSdmhH/+zWzxPhdPl3GbCTL6Hr8K0NK8siOyT3rJKE4IxymmnG6UFincTOIYoh7gzLBGI8XTZvTtL77TM++okfn27uWpl7FL4u7Pi85vTM9lQOP2X5snNKgTvUN5Hm8VuC/Z5MQ4s+NJXhohBewVwaQXe7oGliFBSlk/UOqs7M8UDd6L572VT6ZCSUMk3C5AB30AKjuYD3z6jKQ452oM/VF7CDf5Tccwz5SjS7/XTEi64Tgk9tBdym6bL8NkXXr0o+6adZIHNn8QBIO+Y5K7fYaSDGBjRiki4+KpUfRH7hj52O6m6Q++0Jlv6etNYlyXcYAEwnfFHY6q8bvn9vB3+Ygy3JlXUqWYF3EJSNxKIlDqplmeddiB+s1kw2F9H6HLQRPoW/Wxd6Hb0ZPMuC6rv5FeWPXkDrzGf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(33716001)(6512007)(9686003)(38100700002)(26005)(122000001)(44832011)(8676002)(8936002)(5660300002)(4326008)(2906002)(478600001)(6486002)(6506007)(53546011)(66946007)(66556008)(54906003)(64756008)(66446008)(66476007)(71200400001)(91956017)(76116006)(41300700001)(316002)(6916009)(38070700009)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HjEixvO0txoiHspHC1U6GaXPomxc4SNK9KFv5/JonXh351JBa8Vh+XBvsH8r?=
 =?us-ascii?Q?KoPab3dT74a+QmMljl3cM87QVVVgY4Zzns59GxK5JgIb9yqV66cubU1HDyND?=
 =?us-ascii?Q?6yiSyO6CkiJDKs9HaahBh+D0DkiQvGgvHqxFwnm39iLz5e+HlHWIe8WB8/9h?=
 =?us-ascii?Q?cGOtKf5GVRrN0oWSgXJDnltaUyGSqxNv04fjLKur4GFnIJ3I+eMUIvzXS8pc?=
 =?us-ascii?Q?pnwMPXfH4u+U3q4a1aMBfi/yrjGB1SQIXApbGWHAy5Rkqjy2NCJZxOje8Qd8?=
 =?us-ascii?Q?+sdVgnEFbpxa4iudGvvVLdlL7uYjhiuQLkFCIg9nbDhTRWydFLC2sIFQHXeL?=
 =?us-ascii?Q?ME4gcYT7XabTS2Av7HiVVLMWknrjujLJTFBd7dn6bifj7J/p+rTsoVKQuQMY?=
 =?us-ascii?Q?PJxh1KKhj4XV698GGfE5PupTUODWgJHhKW79QbZW1uErFoNbkvVPr4/0m6vt?=
 =?us-ascii?Q?RVpUzqnms9RYdk6J5vJKQ8PwDNxVaH+gB9r/dDerGVON5el8ZrdzVNqvdyVC?=
 =?us-ascii?Q?dcNTpDhcnL7sT/AGJvmik03fzszAPsu2IX7HAMsMXWhvksVQkNRb/71ufTbu?=
 =?us-ascii?Q?URi8Y2QHQiYlXT5ZSc51dQnm1tJEUNz7ugUhOD8q4XZIp05LY5BTfCntPDHm?=
 =?us-ascii?Q?dE+amzzP3/SZ99ljne+MGupdPirzQvR43tXoh5NakVh1D0PNp1WZEpoyFi2I?=
 =?us-ascii?Q?UrMBvUFt8MoX01Led1GHeNdVJwSU1Q28KKj+z/GTqEKhfRkvWNMwi6iLflyH?=
 =?us-ascii?Q?zobp+8+7WzqE4thFcazouBJlAiHL56fKYJ3C6nZ9TceON8VE9rTGZGi5swyi?=
 =?us-ascii?Q?VAxC1hf+BtJN/edr1vlboc5JuDva1+7iLb21hNoKK5qJxR3fJ04akSPOaNQn?=
 =?us-ascii?Q?KgjhE6Rcg0g8A98RaaO8QoWP5AjOT72i5vFrOZAGqL0CtaZI0uATz+lb/gGB?=
 =?us-ascii?Q?zbbC3l8f4wRri3UkuP/Agt22I/2kT9QiC2VY1xppe5L5JirYOeBBnZs7WKZo?=
 =?us-ascii?Q?inAvvgvvS89lRzFQDp0IimxeNeHq7yQosX9t6uoXPwev862O/TVU7sER5YGo?=
 =?us-ascii?Q?V3akg053FnFYDlP82rguNEY7pSbFMoWPqdp2S5xfiOr17Php+Qs/VJUsg74t?=
 =?us-ascii?Q?2fMbjzs3ln2K/pneK1db7EfBrlvXa/VmGFeFHn3YXRnrxR6YGuDsJMr1g+6L?=
 =?us-ascii?Q?6XbVh5pO+dRckurUIiEPdSRf9NlQF04tdek0oFwLPFSsB3Qc8fWiFToTbvKp?=
 =?us-ascii?Q?UzXHe2WWSjlwQhK7i1sfZHVLJRQnRaeSIAtGURDh9ZbbQoRSkrq35iDArqvg?=
 =?us-ascii?Q?jN4o2nU5fKxjsiJuF1rLaEMzrxYU6n7dmKY9venBNTiWWx2IvEJzned5rfN8?=
 =?us-ascii?Q?1lMUaDhR+lKfZKjD5DUR2YqKhjwZxosfDHxf4pYxzZMryYRkGxRMO9WYsDnk?=
 =?us-ascii?Q?FOOVGEwtxWRB+BI5g7XDOoOpCHOdU5QZEtEhnbNZi7Bex/QVgkyXAgKEgqJs?=
 =?us-ascii?Q?LUA0QvgdTjsom/9dLPrk3pCRy/c7d0st2hlmKobJxY9OuMKYxO+A4qK424EM?=
 =?us-ascii?Q?0z6PXsMUG2yQwXqQl307p8BZbUQDa8jxe80jQwTmjd2mY/lFuil+v/zaaiQV?=
 =?us-ascii?Q?MFzZFxuTc3BKpSIDADC+kNA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E2B74D0282C214BB6350269B1E25CA5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c+ir/mhTKZMQ7X/+XZbOB5PO5NUpO/w8u6cccnkdqR7iAE3rDMhVLAFfwX3GRlm2Z4HyU/bemRgaOL8yoTk8eFqv771EuFxiZJA8Ry4UCFyeyxuw+m/w33tF9unCeRimyJT4JUQCWCu9s3HdBFXkJArCRMOq528HaRI4Xhy3bUfz7DLbB6umGpfapPFm4JhanFXSJ9g2J19teegtQPZ0q2QzZjaI2fHLRhjHfOJwpaolL5mEi1T5OXdIJpqb9sjNE9k14aiolt3dp0wzrkp07ilSfZn2mnT7O0RUbb7idiheKUjIwY91dLBr/BRjzx3SZHs70ddlpTZYthHuiK9Gk7X30Xp524GGKWusD0E41onUa5jWigauMkDNYddl1BsFf+LlDtpXhvyUnOf4IXCLPAmfZ6SEz4Uoh0K17ZAQV8pfNL7rKc682P3xBnL1tunXGp83wq3Y+6FoNGczE5znZj0jTI8MgzulipOGAfirCn2oqC0GtJXnxPNPNvGCSjfvD3xxKLnM5tgmFe9VIaVz+VBym3wDX7s2krF3D5YK3DbFZWHgekDJnKgBxifKMI2NmGyCiR1JEwhDVoT/QUcH9EV4sTfZ5f/NnUVXUoBVg4BT9u6sI3zwjMJyp2JoVTwu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7abf1f-0426-4087-7d46-08dc20c17b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 11:57:35.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irsHYWmPAZ9mXCWdFD+Ze/dGoPOZRxa9Hn4dOVShAVLqw+BE3tx9mYcUb5AXxcCcBMVGaBigU/+y4ft5Iaz55eux/vx6/NwMFAVZyr67gww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6521

On Jan 29, 2024 / 11:13, Chaitanya Kulkarni wrote:
> On 1/23/24 14:55, Chaitanya Kulkarni wrote:
> > Trigger and test nvme-pci timeout with concurrent fio jobs.
> >
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> > V3:-
> >
> > 1. Add CAN_BE_ZONED.
> > 2. Add FAULT_INJECTION_DEBUG_FS check in requires.
> > 3. Remove _require_nvme_trtype pci in requires().
> > 4. Remove device_requires().
> > 5. Store fio output in FULL.
> > 6. Revmoe shellcheck and use grep I/O error value to pass/fail testcase=
.
> >
> > ---
> >
>=20
> is there any objections on this patch ?

Thanks for the V3 patch. It looks almost good, except one thing: as I comme=
nted
on V1 and V2, this test case often leaves the target NVME device with zero =
size.
It will make the following test cases fail (I mean the future test cases to=
 be
added).

I suggest to remove and rescan the device to regain the good status of the
device. The following change will do it. What do you think?

(If we take this change as it is, it will recover the io_timeout_fail sysfs
attribute also, so the code to save and restore io_timeout_fail can be remo=
ved.)

diff --git a/tests/nvme/050 b/tests/nvme/050
index cacaba6..cb1c6f5 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -41,9 +41,12 @@ restore_fi_settings() {
 test_device() {
 	local nvme_ns
 	local io_fimeout_fail
+	local pdev
=20
 	echo "Running ${TEST_NAME}"
=20
+	pdev=3D$(_get_pci_dev_from_blkdev)
+
 	nvme_ns=3D"$(basename "${TEST_DEV}")"
 	io_fimeout_fail=3D"$(cat /sys/block/"${nvme_ns}"/io-timeout-fail)"
 	save_fi_settings
@@ -66,4 +69,11 @@ test_device() {
 	fi
 	restore_fi_settings
 	echo "${io_fimeout_fail}" > /sys/block/"${nvme_ns}"/io-timeout-fail
+
+	# Remove and rescan the NVME device to ensure that it has come back
+	echo 1 > "/sys/bus/pci/devices/$pdev/remove"
+	echo 1 > /sys/bus/pci/rescan
+	if [[ ! -b $TEST_DEV ]]; then
+		echo "Failed to regain $TEST_DEV"
+	fi
 }

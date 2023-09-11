Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB65CA0ED6
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350789AbjIKVlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjIKJRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 05:17:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F09CD2
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694423816; x=1725959816;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Wq0KDj24FkzKEJ5BkEvSbpSZ4x/2B2eI5RBObpnwle4=;
  b=BEK9ctpMO8o9Eji5RrktovArX4jISwCBe5Mdlz+TbkJnuRTeIEULp6xZ
   MpS9GYGCAYNbesuSUe0PQKjObQO/QrDdgtoGvTx4xedw7jNqhXbJMS1hr
   3+2JG8MiQq6fEBJcD1SCvo38nmKUnKk6MH/ogc880V9JguMH8SCOUEhTQ
   fFXTVxk113bMQz9t+gEEKl+48vxk19dRi3ftWvvoWEk96PrgO5iHLBPsO
   /CnSzXTSqwYzi2LTMhz9yncfG8REqiC+unHbAZ/nCffjNQcVN46LgSsVK
   sHinq20U8j2EwxgMJ9RcwMTjSfLMExYn9RDTfWsSYE1xaAfr1XiuBFdtL
   A==;
X-CSE-ConnectionGUID: 86QGxuYDRDupvLI/cwb0yQ==
X-CSE-MsgGUID: EEHlWox3RZaVOHnSjhsstQ==
X-IronPort-AV: E=Sophos;i="6.02,243,1688400000"; 
   d="scan'208";a="355667958"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 17:16:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWXsgze00BQSwZIA1Ej1z1h0fv5bnxHdHc5VXO5UmqTpJ+NdwV8QFbduWrnzCxvlYW/+U1NMYe7DjZob7SnYetdmtuWGaKSO6wdVWmyt7rU9eNQe4x80cMWWNEgf/FBNAzYbg2G8axuIaLoBbU/MkyYt3LQzmROtw8Z1Ari38P6uzCuWKx3se4djIc4qrAJ0HxBdvS+Yu4uSDzAffEseJmOygmGpBnBO2UO6FfeV+lI/P4igB6fkTEALMJM25Y8AY5SPeDiuwK++KNAFDUQHyKKLu7EewQcb2zeU9s8J4e2q863WjCxijYLdemBM9ZOdHfM+VHOTfDpssP0lWRFptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7Zg9y280bo2AMrXibjAVs0VrIOZwkNTtKediLPcIEk=;
 b=BpFtee4pASIkzyEV+JlrnPHxE+KevLzcyULJa8EcAcsRYwZxC+LHODm2PgQ3NJkZAPtUhrJeY/GoYgZUV+qqKIFSMMntlsGCZFy5CI9J+eZLoh98vWOayXZfIapK6Z6klNNcA8mKG2GqBNA+nD7dKU/sXOFvMXr99sGG7s5KlJiu+iSNChZTLzQRr2cXC1YQ5vkMZjSpUf+QZxsidtSVB33WaNmpZNxxV6k9nS9BWF7aYAkSPtRDcuPwSGwaY/RHRJsc0XypconitueR5WWSc2K5LncD0gmlC6izUCnqJDIebvRDLpzTwNl2KNCNwrCv7wELNFLx5m7O3ZSbnOzv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Zg9y280bo2AMrXibjAVs0VrIOZwkNTtKediLPcIEk=;
 b=wtIOxdHMnxlXS/mVx+MWOceS8XcIMmQegzEFhoVugix4Nj9mUwyTgDtp18s3TqGvB0tezKVjNKVdvGHPZ3NrCGd7wSRIpu04vD4rRoYE2vsxrIAn4b6fLF/NBt27BjESovdrh7uCOjdib9SjhxGxnGZPxtUOB+FnLNxVDJs+Ixc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7482.namprd04.prod.outlook.com (2603:10b6:806:14e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.14; Mon, 11 Sep 2023 09:16:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6792.016; Mon, 11 Sep 2023
 09:16:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>
CC:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [bug report] blktests nbd/002 failure
Thread-Topic: [bug report] blktests nbd/002 failure
Thread-Index: AQHZ5JCzc6J135fBEEeFCkPNl2xXjQ==
Date:   Mon, 11 Sep 2023 09:16:52 +0000
Message-ID: <jvlrypdkye74nea4iys2akwfyvskvpw4x3a2zewwxx3qde22rj@jykkoadmb2m5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7482:EE_
x-ms-office365-filtering-correlation-id: 68d22d8d-df96-42af-f852-08dbb2a7d619
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ytBv2ohIgRFzL1p5vTpe1yNqebp1fvEExaQNtWalsPiJD3slbYQa7rUQP5AUa+3C4qsc8vHE2r6SPkVUV1tNxkChcjaSDjmZGWEPuZ/NU8B5qFw/wcpfbcw1r5ePHS98Gac/yvsdc52PCMrGcZfPOJFMrI0HdSwbypSpixthV8yHwDU5DjUXZVpfF4qjDMIYYMDEn8VjIcptCpbzXMFWWQSmZEJJYePK7MeKw3lXF+I0u0gTTubsLKWG1cCVGy2Xfq35vLTU207q2z/ZEHCEdauod11IImIWY/voF/+sO4qvLUqfl8unBgEDhypy7IX1sfXUGuLBNpjFXWYpOR/+iJQpzzn/ZCdlQxAUpbZP0hpi2czdE1oQC55iudQDG+Jk3FdSBxHtyzV357+kVf8udMywQWV2rIgcLYtcNc+ZMh89uSTDWH6WZHMCqwLVO4iG1jOlISa5tg7+dpCuxy2RSKfqK2StHR/pIbgvOqT7Eo8BWPrz/jdQlHxuEz8Bn8+otUrGMxO2Ih1fIIWeijxPLNaSuPlzhxOBZyQVkRZwcSkgSgeCpU7R5hMtqFm2fKzywd1RuK2Ad77DnLHRCdEbdAakRtQM35qUchynHqJrTxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(6506007)(6486002)(71200400001)(9686003)(6512007)(966005)(478600001)(83380400001)(2906002)(26005)(33716001)(44832011)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(91956017)(110136005)(5660300002)(4326008)(8676002)(8936002)(82960400001)(86362001)(38070700005)(38100700002)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUUH2QIdXqvT6sjiR0MXvGkmR1dvukEjubMYisp4dc4/lurvQgWH/lyjmUqS?=
 =?us-ascii?Q?PUpg1tDnXPoC3eKHVeiAIouAx4bNtSx1Xv2vjtMqlVrBtRtUgPuCMBSVZKK/?=
 =?us-ascii?Q?RiHciivJ3XkwgWn+lYaQiTdpVkERzIPJxRuve+XK9eS581zzYFa26gUccM1+?=
 =?us-ascii?Q?zt2NDeZ7QtBnRsEGqLVJPpfsVDlwoDdnESfURHZXOVEioHSne6CoiNBfsQwb?=
 =?us-ascii?Q?txKxL0w0te5t82KZEAlfa/xtaTGOOTNpcadm7O6EA8nu1elzV+s7maetWCcY?=
 =?us-ascii?Q?cmic8rHaCURBOcfZOwMachbgcE7wcZ2MvxC4Djlrlr65ASgjgn3SJ6JOs2N7?=
 =?us-ascii?Q?cBttqpIjuO5jbYoa/WN9W+m9PQV8827gCPyFOHyrZO8ZF/EmtArQaeewxiE/?=
 =?us-ascii?Q?YHR6+rgf5bIAuxlMm25YUNNtrSsctD7o8zo7RwVqO/UQSEERE7YSb/sJmEbf?=
 =?us-ascii?Q?Fh4HCVTQDcE9Bm+YwjjRqIn9hGQWOIRdLS0QewN+szhaFp3V5x17zqikf0t+?=
 =?us-ascii?Q?L/4DC4v07fMhbryKflSSa1UESr/OD75n2Qoyo3PAyIGecK/Vfs+amX1RTIhg?=
 =?us-ascii?Q?3jxHkvQMP5Y/2ncXlIwUjzk5Hx+EsenzoD9W8T+lWv1rARWOsidN09HRTJX3?=
 =?us-ascii?Q?gKeI8R93wx2H9Jp+9oIi7+Kncs/iKMVZSl6E/65Mo3OnSGM9wZDbumGZModL?=
 =?us-ascii?Q?R7FHeajBenN8WEBRrgov5iP4GPL0QkyI57A/wXdkITkGYclUNnLhHBKVfZA/?=
 =?us-ascii?Q?D67v+XeE+gsxbWfC3pkMoiZQme2OGpBHVtXnd2rKQYtCo364R9wAhSkjr8Aw?=
 =?us-ascii?Q?fPABtDVIggPsqvu++uuiq/cLLhvoYrZD+nZGc3H3xFJSARl7TKzAJ1PK2B6x?=
 =?us-ascii?Q?zzDwIBQ0QfHFo1RgePtVodYlmmPDfPkAqv89z876w14mPEQbDCZgHmNlR6+Z?=
 =?us-ascii?Q?W4QeX6P8Crz/D7S120Z5glirIjawriYPoZSBRGZs/P21nOSD4F4lyjnSdbvI?=
 =?us-ascii?Q?BZE8E31TzuxiwwkJkGm7h9uj+KfjM4DVQ6qMJHghlQVsskhae+HriNV7CScl?=
 =?us-ascii?Q?dGPamp9mme+vSyHuMKS2bJKvQDTw/7zxcpUJqnwSYqW91OuPOh7NDA/EWkYL?=
 =?us-ascii?Q?Bx28QwhOR5h8I9WxB5E+JRbYKmWbt8GOy6MJSq3mw3nTq3p3fsAwi9+9SH0m?=
 =?us-ascii?Q?OiVCRdc+6LPAUgIwRhpfat5kdH9ieWmLUOQkS8b5tNtJsaaeEssoYOWJe4D2?=
 =?us-ascii?Q?K9IoZc4fzS04dK4b1PsUbcU/VrlKw63P2W8I1pRb7KgRSd4+N7yiNGF/ZUpA?=
 =?us-ascii?Q?a+DkGKaTR3KqHu8XKK36BR+bvjhtHQIlHz0GPcIGxELjekONEt3XC9yABp0/?=
 =?us-ascii?Q?Il6azklrxCfZUuYlQAQ/F7iv9x5ml2+VryBRTfBbw41qyO31D1ZY3e+XpToS?=
 =?us-ascii?Q?zCV5PRbYQwfDzhVOi+trNtU6iaX/JyzphGrIBEi2l9zaH94FLqlBFI8h6kzy?=
 =?us-ascii?Q?wHgV7ImJe3TZx5d31WysXU79vYzjtCbqAWLBUFn9GgSRp6meFXyL3WLK7DpC?=
 =?us-ascii?Q?db+Ei2/lq0yL6/t7cc2ZqL+HDcC0kcOz89tyBJjBu1GPrAlg/Z6eOzrp8vJO?=
 =?us-ascii?Q?MsvsIFZV3x2+SWixP0CarnA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49CB0EE8A08FCD428C3AD979921B86FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a0WuyyMWwfM+b13/lMJKl5h2TdS9MRq3QDEGyCxNbTFm0jC+4EkS22bjPwheCgi1mBlvLEzzyuwik41DB6G+hWryIEo94XdHILLkprkMAszPYoLAtVUWeG46b2abtLgpcBMjkv/gSk3yEwZsEE6ZyeGULBsMz7yUyfqxhEAszyh6B3+HIT6aa6Uc2NrjrNhfTQZA1jJBCclmi9nb5nuviU9P5MvTEgaO2zo3uJWPA6QfMNA+7reG6598EM4DsaA8Waey+x3KtQdYjmLYQM7JSKVzDmC0N5twusnxk0fkEtbvZ73l/pawNYnNFTIjd4SfW0divZMY5dMJcoN19hcbRcBH1ZTTOgaLY9McV7EwK/rV28542tRYJ6jMAePkGeUFgUN0o0rXhFTmRYFUm5VaR+po5LVGzqLNnbnMiwVAp8CeS9XIg7fuib46wNxHZ14NEje7AXtCB0CHuqolUKnll4RhdHtl8+uOpo0gSEopfpeKcI9mAm7yi2gYZt84ngCaf5UclLFwgchGmt7LcYwD2ofh2MO/WXFnGhqKh40dylBlpemHWUdicKD2VGZpl33/0CvVd3XPwRvXFlL+VgJquXqpbGCd9WrmLxzjS9jQYQQUR86Sd/tq5U72ZMg+UPAdnIa8zJxqI2rQvvYXGpPi0W4bCe3s0K496a4skti7wU2oQEcPiulTxtsifw62/VyBBBAPKyIVba81MZbaLfkj0QTmC1VZMrMWruZhenpbO7GgHuiInqTOJJkTdc62k02VTMmhxzelN5TzClxayL/EFQeEb3m01g6AOsXWTladqcA7Yl+VDv8GhTZk6KGZg3a7eUMXuoRRyOj3O1jALbYM21hMlBb7/wontvOHHHVG5XYur5Xyp2l5qgFq5HQZD7LXHNlA5bSqcFWhUjjO55IqrzEJhzevAb4meoPRFdAvYyI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d22d8d-df96-42af-f852-08dbb2a7d619
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 09:16:52.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZ4hyV/hieB+6P9y3Se+qjraNhuAXJRoO+lu5ONPjYWcHvW4ENuzpZCUHu3d7BN1veLyjixsHQ1MjWzILrQX7P1m4ZMYRnDN4hnJOZ4cjhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7482
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I ran blktests with v6.6-rc1 kernel and observed the test case nbd/002 fail=
ed
with the message below. The failure is recreated 100% by running the test c=
ase.

---
nbd/002 (tests on partition handling for an nbd device)      [failed]
    runtime  1.620s  ...  0.369s
    --- tests/nbd/002.out       2023-04-06 10:11:07.923670528 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/nbd/002.out.bad      202=
3-09-11 12:03:30.901246261 +0900
    @@ -1,4 +1,3 @@
     Running nbd/002
     Testing IOCTL path
    -Testing the netlink path
    -Test complete
    +Didn't have partition on ioctl path
---

I checked nbd changes in v6.6-rc1 and found the commit 0c1c9a27ce90 ("nbd: =
call
blk_mark_disk_dead in nbd_clear_sock_ioctl") [1] is the trigger. I think th=
e
test case expects partitions on nbd devices are kept after nbd disconnect a=
nd
reconnect. On the other hand, the trigger commit looks removing the partiti=
ons
after nbd disconnect and reconnect. I'm not sure whether of the test case o=
r the
kernel should be fixed.

[1] https://lore.kernel.org/linux-block/20230811100828.1897174-8-hch@lst.de=
/=

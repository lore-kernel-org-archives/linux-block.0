Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD62C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiFWP1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiFWP1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 11:27:47 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11573F315
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrpcI1JPJho9d5DkFG7pFlw7xpJ3/87uxstCCQDNaI5FP1chv7mRj9vXIW2TyUx0pFKE5HlstegZ3lsWGIFuR826b5uu4Ij3cLTXrxfammrgHmu6YKgbWfCbuvpI8bh6+I0xV3fSaAVB9PcSZcI3gq0zgX2AZy94GrOh2ehnZjsBsb+wR8F2vAMvUl0QneiQM5j6hJwvlcPuwzh7hkRSb1xJrZzHUxdiP9QIXIj9c5g/eLzucXh6pAAmMnBR9G0CwNE/5KszN5Ywu7/GmvTapFAokPHYCrjFo2tuDkl3wy9/9Mei64lIfytqgInlg2VjRCioydzLSFjsG7x9P+ouSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Dakn2S0L+ZbavQ7H+M7KgVnneLEtVQ58yXFnoIilw=;
 b=hD8uqQ8H2q5e0VzWzNaZFDDQpeXI/TfvXKIYHHTPeyS0AnI52foW9L/FYnezgq/AfB8BXNGmDfCKQmUcnsosNvgSHlbpsvH5YEoX1UvVJ5juN4oGkbbGHtfYrnO/n8Wzm0Uul9Ao96RLSOygVC+Uj9vy4kuaiwzGFbH8qB++9i5U5XOY5hKIVfNi7Yj8GOqCzrkREQ4b+5UZJoJFi+4qZ2UzxvVgxPQ1y/vgPZNd2X6XkyLTh5wehg8EPwO2ExaHvli17mrSOlnXlwFK6UlBw/kXGxvZdTuUdffWygj2iIerpWSQOvZMqz43ykKiU3TOigc1IsCR7Aa2nY8xCXLYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9Dakn2S0L+ZbavQ7H+M7KgVnneLEtVQ58yXFnoIilw=;
 b=h/Jzc4lQST83+HQk9QzssM11Jy72jYAzd9bKa0GfV9X+wlK/FskJRIYrtsWZnmGo7voYicOo5yYKoQxn0z7F+sZKKRwx+9RgaXPQSenvmiBmvxtVIYdIPK7y7HgjkRs7yz/TSgIgjzS9pvJCWKhcZX7Y5a3cUoxwM17U4Rmzlig=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by IA1PR21MB3690.namprd21.prod.outlook.com (2603:10b6:208:3e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 15:27:44 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f43d:6168:3eac:d055]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f43d:6168:3eac:d055%4]) with mapi id 15.20.5373.017; Thu, 23 Jun 2022
 15:27:44 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Question about merging raw block device writes
Thread-Topic: Question about merging raw block device writes
Thread-Index: AdiHFR/O/apBVKitTXairniuc6HJ9Q==
Date:   Thu, 23 Jun 2022 15:27:44 +0000
Message-ID: <PH0PR21MB3025A7D1326A92A4B8BDB5FED7B59@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9eefed94-8cb9-419f-8b6a-54707b07e910;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-23T15:22:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a618073d-5569-43b1-dd72-08da552ceb89
x-ms-traffictypediagnostic: IA1PR21MB3690:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWpc1n0BQ91LrxrJW7ea0NMOOuPlvr9P/FXwHsgO8jipRq8kd4ZhxpIwObM9zOH/SbNg5uaUmew3TD0UO8WJdxEUGy9pwuNjZiR05nHcklHO3O8H5zbvdhjbsYfIY3Sz7MIJQUiH8bhThY3jP++ryYIrtM9SBh2YW28bcpOX3X6b8AFI+R2tc2QOxMo1y/d5+9bZs2HPaMIA0elWQtcofNF4+a7gYkFtJeFUI6sbVOD+VRujtUO0pyPztT0nSHH+aG/Qd6G5dSEjERkHiQpLuL9HhPlAAdj0vk8/IBfEsvWWMvtAZJA8oSys6uBU5yEtY0JIvByLLD/WvdxiLGvR9xU173f36Uoo5PaEYqD+Aza6WbULa2KuC7b7V8sx5nprQCmn48krNtrSkLmc4Df40n8HJmAWjNDLUWoc8X2enOoWLaMJx/wFPjSSIEoiAQ7ywXmjJK5imp/LELsMWg7DMsdcqwYVh0aQ8LZkyfVSgioIhhYG92zkx2tRVP85Z/wW4T6T8P7a2fVRd9HkmXcsi5dCVHk+j0DfmjLbnJmrlCwwCo4vpp5+srPlLiApw9O2ZBAMAZse6zMv7fZJjDBDadDolLm5hTQ6UExl/8zYsmpndQZFEOT2ruLkRucp8wjlqTS4sZ1iVM937F8FQ+k9a7lSUagdOQk+JeMtMYsD8tiIYxwwBkV0tDRLOm3wN+RFpa8JkXELIdodxiClJFTuZnyi9agiQfYRXxbo2SJS/hFHm3WJeqkTYzejrP6ImUl5YH/jJgYn5IjuqC6q6SmZxVIFN4fkJEKjeZuqol2Fz/0r1/276/nrxxNK7RrPT2rNz2hjVNHS8XWg2HBjp9hKGOdHCjnmT0RKU/616rz6uQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199009)(55016003)(66476007)(66446008)(76116006)(66556008)(10290500003)(71200400001)(8676002)(83380400001)(66946007)(9686003)(33656002)(5660300002)(316002)(38070700005)(2906002)(8936002)(26005)(86362001)(8990500004)(52536014)(41300700001)(186003)(478600001)(64756008)(82960400001)(7696005)(122000001)(38100700002)(6916009)(82950400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eugP4wTak3P5TmdOSU+YsKp7eLiRs+3g6WJ5XkIslpdTfR25ycgohpZH/4OO?=
 =?us-ascii?Q?9kC4/8wNumi8GANugmUQb4ipzP4st8zJfgho1W0GNdNLMJV0P7ZBCAYx52vr?=
 =?us-ascii?Q?vWcTKMs4n3Bo8GEeE8PgL3ASu9rWtto9eKnu1vgLZ72xJV0A1XWN69TXCarI?=
 =?us-ascii?Q?BNLTqG4y/7WMEdOC6QKWrsw8XkTf7SgVbKr87f2kLMECpSvBRsbhsjoFw2Ua?=
 =?us-ascii?Q?npNHXEjbf+gHBHQv1Z7PWFS065xEJfbUuFjPWRhOJmbXQprAAWa8ec7goc8k?=
 =?us-ascii?Q?D561gbEi/kQXUpYukhI4CkCC4GmkeLlsCPNxBjlR3duJVxSYcnVrr9eMttwr?=
 =?us-ascii?Q?g0+qizh+5C8htetM7hns7gmIinH/a19LpQeIk40Sa9akHzkdelwbKQhKXQdq?=
 =?us-ascii?Q?j2RiY+itj9lOSaeTunVem4LsJzJUBzEhEqzB+rnaMRS6KbKan/LulvgifUBp?=
 =?us-ascii?Q?u6S/d0JnThOyfVbILbSJ5zjQGXgFybNHOYlcejwplEIk/x+TxxWld+gvdpRi?=
 =?us-ascii?Q?kjXcZFXs7wBClr+5QDGpqs2voJEjrLZoSmvrVx+BnQah07+redp5Bv5LkPk7?=
 =?us-ascii?Q?amlxm+CF68vA+QsFhLOyzstaQCQHMVczA9sOzEMKWBMKm+koBiKI8XK1ShPP?=
 =?us-ascii?Q?e7Ip4D0GzAoTHbtRoWtJd42BMxpudX8rRjWM/1D+l6HfR4IphUUNjMqTCPFT?=
 =?us-ascii?Q?398NTe+pkz4zXaAXGzklGRifnjNXZsDauS29q99Dp7WSL7Ijbd5Y7kRDO95v?=
 =?us-ascii?Q?SVj6IrJhZj87z/9fOkt9QpEGggZzQv05z5XYF4NFDctIdueGMVHwarnFDB+l?=
 =?us-ascii?Q?7cDF3kzl1Nmm+bov4rpBzgRy/dzaNP6C3pmDwUMV24oe0MFItUD5vufWCqyH?=
 =?us-ascii?Q?rdc3Onk6iF58WGdPgwoMN3TQj19T1Wb5+By6Tt/H58xnWVXnEh1eFzezq5LP?=
 =?us-ascii?Q?oXT1rHRlv3XQ1P1wFiqizjsfMGVyZibgfDT60QXzXQYmajFz+TdoB8GxqCvq?=
 =?us-ascii?Q?2LnLz88mPXKhacsmeXdkqhih2m8KmOQcHwbg7ED29U4jhYoQ1NTdqUGtASNh?=
 =?us-ascii?Q?i9KQnyGX2yVm2wva09y2p+cO6TRpRRuXWbdLhEWGb8iX82ATrCbwf9UFuj4i?=
 =?us-ascii?Q?QoBYCTXAOi2v6rNvz9OXMJE/X+I/THj1nyweBQQ0iv51K9CHUWJ78KEyYWvt?=
 =?us-ascii?Q?kqXuGWeX3fMqFWl/x7imeq9Mo3U4gA6RYa+K6ANqASyJp8BzFuBrIGaVmq3d?=
 =?us-ascii?Q?yc6l6MAZFm6y2kiGPRtzukco6+2Adt4LVaLN0HM2q6oH4EZXbyltZG+2NaCR?=
 =?us-ascii?Q?BdmtyCnPwqJx0m8xX5NJKudHMdJmSJXlBWNWR7OWwU0XjlGvJBtUuQJhIZEK?=
 =?us-ascii?Q?hmj5xh/OiSQ9UvP+72Kiba4MdLNbemVUlGIAF4WDjnvZ+gKslf5esSZS0435?=
 =?us-ascii?Q?LrwjN8AflYleltI6jm8b11MWgM1CvyttvGkzPwHHlkVHatSd97uuQ3M9uK0d?=
 =?us-ascii?Q?QvTEIzFPgEftt1QKYRZj/eEGIGGhBGftu46rb/yK8GA0DxKqJiwNlkjiuItX?=
 =?us-ascii?Q?zb82kLi/UpQ41gM906cO3LaoAtQcqEi4eaw61/j0PDUUtg4zzs2o42FjwTXT?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a618073d-5569-43b1-dd72-08da552ceb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:27:44.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFdg9tHzlfQCWHVO1rfA+GuN0QYl9wMrehTsbNP8u76VtJn+0aKbGdqbaGXpgUhnNekVA61ENosyuxy0VgsQxcBcqJlKrTrb5eKwVGzg8/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3690
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In using fio for performance measurements of sequential I/O against a
SCSI disk, I see a big difference in reads vs. writes.  Reads get good
merging, but writes get no merging.  Here are the fio command lines:

fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D64 --filename=3D/dev/sdc --di=
rect=3D1 --numjobs=3D8 --rw=3Dread --name=3Dreadmerge

fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D64 --filename=3D/dev/sdc --di=
rect=3D1 --numjobs=3D8 --rw=3Dwrite --name=3Dwritemerge

/sys/block/sdc/queue/scheduler is set to [none].  Linux kernel is 5.18.5.

The code difference appears to be in blkdev_read_iter() vs.
blkdev_write_iter().  The latter has blk_start_plug()/blk_finish_plug()
while the former does not.  As a result, blk_mq_submit_bio() puts
write requests on the pluglist, which is flushed almost immediately.
blk_mq_submit_bio() sends the read requests through
blk_mq_try_issue_directly(), and they are later merged in a blk-mq
software queue.

For writes, the pluglist flush path is as follows:

blk_finish_plug()
__blk_flush_plug()
blk_mq_flush_plug_list()
blk_mq_plug_issue_direct()
blk_mq_request_issue_directly()
__blk_mq_try_issue_directly()

The last function is called with "bypass_insert" set to true, so if the
request must wait for budget, the request doesn't go on a blk-mq
software queue like reads do, and no merging happens.

I don't know the blk-mq layer well enough to know what's
supposed to be happening.  Is it intentional to not do write merges
in this case? Or did something get broken, and it wasn't noticed?

Michael

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7148C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 06:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiCVG4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiCVG4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 02:56:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14DBDEB
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 23:55:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M1E8Rj019159;
        Tue, 22 Mar 2022 06:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=O4gUpbHm7NXwePIxKBaAbmBa9Y7O+t/XFgeB7Yn/c80=;
 b=LKlUGrexS7eYNA1VfgVVDYf6T6xbzpBtl5Blq/H94Xtsa5sA6d56FEWigehI8UkkTYWP
 xDu7GvWK9neZ4yYC1cIF3AarNrNHdUpF6sYC3/HHpkX9jk+AtxwW0PjE0M6Q44JZi2UK
 zOxDQc6ppNOk0A4soLRekyXOUEeYcDmp9J8eDwbc6D3091Cz+vhSfYRZ0+/tgMX7TZqg
 NsZW7fbhnv213UBhT3IwMJ/VyklhRXcWwzUoVHuWFDBu4/fApFPg6gkZD+73Zd+oSeKt
 enUhv58LJeFZt0dfGSYte4IDeFSNyJJ6zH7xaq606Y4AWCauCdeYRDTyroGA4uh1z1Dm lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt5dkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 06:55:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22M6pxeo069268;
        Tue, 22 Mar 2022 06:55:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3ew49r5qr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 06:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQmN6y3gzFfjGKN8tNWXQD7EtJLX6wBLY3Qw53wDAJjWTBtptt96NPcmi4JICZRQeZz2mJUDPdGONGHzS4HzT3KE3zWDAp5WMMcFmfe8dxGO/Huenmtc40iBOTfEFmQXo1eVx/7Ioc/hAyAhrPsXBAa7LqbZjss6M9wP+tVt2o5G68lDIdFT5jxqwAsbCtjh0SsfExBVtM3cI3wciXDGOS7wSiL3pDL7NL8uSPa+xUu4xN0dS/jrbdCskF3+Hh5Cyn7r37JlkJayOuFjTLV4UNVt49oDagBWP1ohAtMQFDUT/Rj3s9Hg8NFhMBaIczikm9HMBBWAWURZxrO1EfYuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4gUpbHm7NXwePIxKBaAbmBa9Y7O+t/XFgeB7Yn/c80=;
 b=a/UJzze8XfOpyph0l9a63EJ+BmybzWmFbT3BkYCUWUSlZoALaO/Sp8v0ztNW1fuas8OHUTiGq7mZDcS4IYVIvpan0/IHwVnJAAcfgTFeMew0sx+6ZV7mJ2W5pTohti/YLoJscFClddm94HDSY5mM+kkIHAplCh2aTc5NECTBbRFEU/3uN2tubs3j0iVAcASl5i+E4Rph9Xn+V2KO9FyWzfTtOAX3TpYDA6eiMz9umSJXvPnp4Oq24ta4WrD0OIRflO/RJnPynlWVkdy+VDxGyc5USOmBgP7iFhWtGnpKSmjsPPkcX9iVq38Qz7R5/AB6yRzd+ZGJyUu9bY89FUnbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4gUpbHm7NXwePIxKBaAbmBa9Y7O+t/XFgeB7Yn/c80=;
 b=TIjCZ2udPAbazfVV4e2pT03neDgXJGiKZ+3bbZ0F6OuwAR/5qe+gu4OkjxNHybs5WZTYB/o6ChGdr4ZvzwRPFrCK4qBSW6jHl0xWArDBQAvqQCKoI7DHu+/tqccNBO1uPu8JTkit9+z7pIBvcQK5ai6erfCshMDWXyauqMEXsz8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3300.namprd10.prod.outlook.com
 (2603:10b6:408:cc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 06:55:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 06:55:15 +0000
Date:   Tue, 22 Mar 2022 09:55:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block: avoid use-after-free on throttle data
Message-ID: <20220322065504.GA24523@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 325155a6-fe3a-4adf-0642-08da0bd0eb41
X-MS-TrafficTypeDiagnostic: BN8PR10MB3300:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3300D19F10613FBB2F9DB4E68E179@BN8PR10MB3300.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKbmktiTTGd8ArvQUdOOPam7ZiT27msgNPsftth8tC6VbZyh0QR+tk7HP7CQKvNbZOePNp2MgX3wgvY9KpohWJ2aNSzLsqYS717WS7IaysOKZWWuaIlPeNOsKD2UtCFsNQ0T68hMWgr6QDe52XAZei8RTxSNvo4lz1vuWJ0Y9GnRUneMUzXS+czIbQEkRPVNIILKaDhsItyP5YjTCG6QH/3+V3YxB7ySi35kXhL8xq95Ynt1wI965iTnQ+a9SduBqK65Ggw4dAp+ZshcuRSf2ox/aZ6F5zK21D2GRVld3m9y3Ape3njXpLmyKAy1ZsUQ5zx6jqml6kNsV1wUnbVuY7Ktd8e/fxQwlb28DDouamwa25P2czD6Rv/fmun4OXo8jg8Kx/lFz3ZYMqf+TdVwwmt6kHfoImsVnhk66OtL0JrlkXWuPq9ywSVInC1KPHnxEw/CwmeubQojp0KTcBROSDwxLf63T0bf4poZy8V8XjJ801rek1lGMIFy+AIktI2v1EHdCTMib5byvwzDhnNqDYyh3bbwYSB3KVL5mRtoPc8DZ19/7/89NvGsJd1dIe/Tojb0TheanbLcV+Pt8JVW2XoxuUrmUahr/SKm7wTQ3C4fpSwiPtr80cN1m9lb3wdRmRslKhVapXk+8n9cqOXzCYKx3Dht2+WzFj63z2fpUz5aJsrKXUe9s8rYZFZ2yIYXXbXfNZWX6VzBrKmfV0zg6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(38350700002)(1076003)(316002)(186003)(86362001)(66946007)(6916009)(9686003)(6512007)(66556008)(66476007)(8676002)(4326008)(52116002)(83380400001)(6506007)(2906002)(6666004)(26005)(44832011)(8936002)(5660300002)(33656002)(33716001)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lja/vME5+GAwfNBC7LwW/ve91uTS5CkF/TJTZhGfdgmg0dpk4IQr9e5PCRAr?=
 =?us-ascii?Q?K2Kh9PAG80TkCReFie33PqpoH/r1QFQZSb6U/iq9iacSYLheZoWkw6uCQXxS?=
 =?us-ascii?Q?rIVVi22gW24a7kIAjcuHgpUo5ZM0zeY0BxYUFeoMrE+gm2NJPLSv1XWLqDwS?=
 =?us-ascii?Q?hRtIKtaW9UHABA//cfoadakiq0AkWsq8N6roBs7UP8fEYzYzEMHdPH7bqYSH?=
 =?us-ascii?Q?L+zsb58x0eZABMAvXfpjEaTc0ol5BNfCXhw7AUuZqr44i9K4FKE4GS+UE6iA?=
 =?us-ascii?Q?Te8PC9g3wnWrfPcIO20YqlOgh15TtuAvu+wzaIvlJZ6MUPXruptvC2B+X9Ob?=
 =?us-ascii?Q?E3v0GoL+udlNWlzcZ/iKor0XRA/ySefEEgf7atyoM60dYwP/jHvgoAdNCwU7?=
 =?us-ascii?Q?+RNo9M0bLvabSe4xW5mbqdBVKvU/G8Y1ZhhY335YGjmW2X61vMcLCPsIAMXM?=
 =?us-ascii?Q?C2I3rYSZBCznuTzHBObqthoR4SDkvStdgogpLYfYJ2Em1463Xjg+9HqZDfcQ?=
 =?us-ascii?Q?Lsoy4Gsn25VX+08uOMJBJnTtm0mS3+Lq76I7PF4o9L76OXKJusdI5bz+qEgR?=
 =?us-ascii?Q?Cs2a0uWoB9lw/Njmx4Ue5dQQCsLktmHoJCy9PVekNfs62HqNWbswePuHR7rZ?=
 =?us-ascii?Q?dfWvjatNRAKSqgWQ4rT0nmGv+Mv9S/BzMNguuZRzEszZvmFTla2XMECfeupf?=
 =?us-ascii?Q?ZSOG1eiEVEJU5PyFxQKYhuuFeHF3YIoKg0V/XRB8JpP7OTgbolxojFdgWrrr?=
 =?us-ascii?Q?CJrtn8vXMBjtzAiGXuW8khdKWqjB7PkhNPOOjBRy3/va6sUe9PxJ+nDvuCpL?=
 =?us-ascii?Q?GgKOJkidJ1OebKafQgZ/rLAocQGDq5DZs+uqTeBI1YpPei35SAYMqywew+9l?=
 =?us-ascii?Q?Y9yL7asnK5zh3ZIRxCRSJPyLdcEIT9AW7KTI9xWEza0rizrONUC+teEwYFg0?=
 =?us-ascii?Q?ACHuGTuUc5mTvz/owOhk7jHBKxZsN4F1M+jY+/g0y51GvvUYKqU+8BAlw5hH?=
 =?us-ascii?Q?2Ua+xUWFb8JJnCnr0BXoj1RpWRcTg7OXX1L5UG02kosljQHsdMAmRdUWqgrA?=
 =?us-ascii?Q?AoB67pAGjoxGz3UDkQx+BvZCxmg4cB/fuxczkyxdPBSKh1CZQy6Y3Qnf0wk9?=
 =?us-ascii?Q?bQkN0vl8hCa1Np05cQPBLc5JtzGjeo/VogAbV3Ss/Bjn8BQLhJzm+17UgC+I?=
 =?us-ascii?Q?9RHUxmHvsdj4C91c5sSrABM9x7DV6RWzYLIOUPvYch9JJlRSC2u6NfzRY1ra?=
 =?us-ascii?Q?eOMWUEYiHhZXoHtESyTkAYr2d6/o/5i+Yq0Psso3TbGgnnrk7MdcXDg0F5ne?=
 =?us-ascii?Q?3SWRkV5VdcFoXx4VcKIHUTZk+3lLn3NzCIZ67vLbPODwUrSgwLsAmlNKP8eX?=
 =?us-ascii?Q?qo2bmU5r1j5tYDDPea8el2nKWxr/4Mwv2EyHJDWOsAhHxSwJxuLRb4WyG4cm?=
 =?us-ascii?Q?FlfDebQNGm98Rt8apWdYEeEERCnXEmRUFPy6bwamSv0fQMUbJgy8GA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325155a6-fe3a-4adf-0642-08da0bd0eb41
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 06:55:15.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8tVNbADq8Eub4S1sj51jUwMyST8Hm6l9lF61O9Is7VXwFygBSwSD3uH74zJa09aAFMFLW0UK21qSzylnJyT/jK9/fnyONKgdvcBizSa8jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3300
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=363 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220041
X-Proofpoint-GUID: 6croLW2YOKrD16CUPirk-ntCIiXsH2BB
X-Proofpoint-ORIG-GUID: 6croLW2YOKrD16CUPirk-ntCIiXsH2BB
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming Lei,

This is a semi-automatic email about new static checker warnings.

The patch ee37eddbfa9e: "block: avoid use-after-free on throttle 
data" from Mar 18, 2022, leads to the following Smatch complaint:

    block/blk-throttle.c:1189 throtl_pending_timer_fn()
    error: we previously assumed 'tg' could be null (see line 1147)

block/blk-throttle.c
  1146		/* throtl_data may be gone, so figure out request queue by blkg */
  1147		if (tg)
                    ^^
The patch adds a new check

  1148			q = tg->pd.blkg->q;
  1149		else
  1150			q = td->queue;
  1151	
  1152		spin_lock_irq(&q->queue_lock);
  1153	
  1154		if (!q->root_blkg)
  1155			goto out_unlock;
  1156	
  1157		if (throtl_can_upgrade(td, NULL))
  1158			throtl_upgrade_state(td);
  1159	
  1160	again:
  1161		parent_sq = sq->parent_sq;
  1162		dispatched = false;
  1163	
  1164		while (true) {
  1165			throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
  1166				   sq->nr_queued[READ] + sq->nr_queued[WRITE],
  1167				   sq->nr_queued[READ], sq->nr_queued[WRITE]);
  1168	
  1169			ret = throtl_select_dispatch(sq);
  1170			if (ret) {
  1171				throtl_log(sq, "bios disp=%u", ret);
  1172				dispatched = true;
  1173			}
  1174	
  1175			if (throtl_schedule_next_dispatch(sq, false))
  1176				break;
  1177	
  1178			/* this dispatch windows is still open, relax and repeat */
  1179			spin_unlock_irq(&q->queue_lock);
  1180			cpu_relax();
  1181			spin_lock_irq(&q->queue_lock);
  1182		}
  1183	
  1184		if (!dispatched)
  1185			goto out_unlock;
  1186	
  1187		if (parent_sq) {
  1188			/* @parent_sq is another throl_grp, propagate dispatch */
  1189			if (tg->flags & THROTL_TG_WAS_EMPTY) {
                            ^^^^^^^^^
But the old code dereferences "tg" without checking.

  1190				tg_update_disptime(tg);
  1191				if (!throtl_schedule_next_dispatch(parent_sq, false)) {

regards,
dan carpenter

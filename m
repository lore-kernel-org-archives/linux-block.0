Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31100610E8
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhIUNhk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:37:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11272 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233131AbhIUNhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:37:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LDDBXV017239;
        Tue, 21 Sep 2021 13:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8OnAy8lW5doNVj9DmeNOr0ovmu7cyyVmnY9cJ0A5FfM=;
 b=U7t1EydUuD2iDxhbKvG+Lzkl/MKhkgClQmAInmg+8L50A2sIYZQjsPZsQ2inpONQkiX+
 DFG1GqB9Mneia9e7FRTwx9sILVNGCLVHnbsZEpXSzOlgT2SQQVn6QfJH1KHkmQ+u/z/o
 87aye47M4kbOqLXF6Fy4YEd8eFcYG8nkEfNw643ZpBX2fb9kMxRhmeDMTWJTpjKyptbr
 y13Ww8on8BlAok7+3b+R35v7raxYjlTULK2guk0+4ZZygaz/7l9pW8XNmq3SRORaMH+9
 bFbenmKHhX0lcfxmC6skc5tgrtkc+tF/IV4KFbxFpSPc95zWpyNBg4yFGpa490AYYcJ2 mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b79adhvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:36:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDLYbi121625;
        Tue, 21 Sep 2021 13:36:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 3b557x27fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYFlOEFL+JVk1m0gYgtniCRBWVoChirTSfAeFUIHEAtParfwtnm8EofK+H3iiZtANbAHKGTpELFQ+/xLBe3+bVe90gkqDK1DIfSelZx+O2Hs8H1bUINne+BBZpBleK+8sacBQkQ7jOoeuNWBgkrQs5wsLPYAdllQV6MU96muHgJlc/W98zY4LC4ArIsy/hvfWKlzysTLOa8qEHYLFdlNA6O3VE+0svr6gAr61KyVFZ1cs5uicJQ9f5/DTHonDuPpEHYIyMwisKN9D0VM4vYZWKlp5I8mAd2sSHd1pafoYvuAtAz4My6omzGJh5SvT98qd3wpcrUSLFvV0WJatmaJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8OnAy8lW5doNVj9DmeNOr0ovmu7cyyVmnY9cJ0A5FfM=;
 b=QHwee68gAtoCLZiKaiz7vBb/xRg31+h7EOr/G/rlII+nKcbDuvby780V4PD0hAISe0fjJjh1XPKUb+e2dRNbv66uJO+F6b3xxI2YkxoCG1Rv85zJlW1KUq91Qfy9mMxJDONJLZkXalB8cTnxMSTmCgp1jn8xxa9fboW2jdUGUaj7apIUVb4mc7g+sFKUrLXsbwazg/c/BOzEpZamoH3+wisjGZj4puvM4XGKPLQIzwJTg2SHXq2INtbV7vuJNGIv5xWdp2/tQKyy6Tv+SwnBmJM+2E3j82WLNDvFdY/TU6POqKJfM6ueqDzyVcoRF0cU6vEEFhfj8oSrr3G3veQdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OnAy8lW5doNVj9DmeNOr0ovmu7cyyVmnY9cJ0A5FfM=;
 b=McbbJvqr779FTiEJLmRRWRSWLvodyewG5bhhxi2lYwOIgjLkKFYQQGJhL4f+qQEOx3Oj6i56ns9cByrijFD5+aL2yehNlib47JN6C0Ta5Er0dbWuwDDBwCT8CvA//M0SutXRVRHcxP86pR9VjPl+te2B7qE2CL69SCQEINFjT20=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 13:36:05 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:36:05 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/8] loop: use sysfs_emit() in the sysfs dio show
Thread-Topic: [PATCH 5/8] loop: use sysfs_emit() in the sysfs dio show
Thread-Index: AQHXrso09F3cs/R2aEKoX/7mi2AJRquufaeA
Date:   Tue, 21 Sep 2021 13:36:05 +0000
Message-ID: <58779541-EF33-4F11-83BB-CDAC2F54DCDD@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-6-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-6-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7625572c-3e1e-4148-37bf-08d97d04c300
x-ms-traffictypediagnostic: SA2PR10MB4604:
x-microsoft-antispam-prvs: <SA2PR10MB4604B5FD8BDF9D091B2E67F8E6A19@SA2PR10MB4604.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+sdcHtRCJY/NTE/oB6ScR7BVjWZZODYAiuZoyzn14ue8lzPRHtqe9te73ckMmPv7QtiwrMGZcvSswojEuKzI/8p4xZOT/uCK98Xdaf9sEBVY/YFJ+b8cADHcheKfZBz5gCXeLvPG2S+Jwcmbh1BYB7To22yJTuGPMQz2lGn/8QVcOaYGVFAaZLA1T4yX36sKb4E4A/ZDbu4qzke2aThL61e494TnpMOJsTVpL7D2ZE7+Oo2/fr+1yJkmm1kS32qKlKsTIBt5hHH1N6c9BvXZ6n2gPAIFSYy8lTY2eS+tasZNnhC/0K8O4tGqdiONf0RqLoNj+gDH9CplV9yB3z9btNti6q24iwAXcq7HQLD7PEr4497PXcP0YX9jZUAsep7s/5XtqQpHaf6mKO821DXdy1nAq8e4vP3RHWudEaXsvufAu5skSJnwQGLD0wxmam3GUxUSVkAkNsPkTIHjL4/z17FQznxFFSlv9rP4CP1Y8NCUyrVipoZm5UGPer5ctIVDp6aMWNy2MGZpJnlnPuDCA3nuNQTK0Fh0dpM4A1HnMEMSyRpyyF8vqfQRkaKhfULUcPVAcq3RLpkpOg4lzp4rfnygBuxn2Hcndta+cT9K58vfClSeCtc8PSAxG6Lni+NkClnLXLQ8F8zCni1seMf09RtgC8heMrwb1Z2wsaXmBVAQ+2xPEe/S2XMlEEz7rmBu6t6zKeL3GsVYkl7x/lL4e9yc43BpG2N+PDgMACZe9j89/lbr2TNkpGsrcblL+4e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(38100700002)(86362001)(186003)(4326008)(2906002)(6512007)(6916009)(122000001)(26005)(33656002)(54906003)(316002)(8936002)(6506007)(5660300002)(66446008)(6486002)(2616005)(64756008)(83380400001)(44832011)(36756003)(66556008)(53546011)(508600001)(66476007)(76116006)(66946007)(71200400001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9RMwKvVRC1GkQRZxf9u9rBEWBT62RIhoRB57krj2bgb/pahLWwsdQS2EnKl/?=
 =?us-ascii?Q?LaueK20vhG+eMAkzlk7VuYcHIV4TXICsW/D6FbFiyMawkMQJ26Dg1vUvMRwf?=
 =?us-ascii?Q?Ks/fdSc5eZbznsZGGR0g/if31o6C0JYggaTm2CO5ebIhnoZpu4VYZRoiEJ6v?=
 =?us-ascii?Q?OPPb24EON/brzur1YRIwoX5mloHBmt0jX6qGsbHLJ1WLUjGmeAYSC8gGzqOr?=
 =?us-ascii?Q?ux4juCs38Se0LlFsoEtIjRg3PdFH5ZglZkSkmfK9npM4E6pN3oRkGIW9ltpT?=
 =?us-ascii?Q?Ge/lWdEp7qvFgbInQmCj6FeBpXciepkdpjmNr8YnvWXhyRJWdHhTQznMtPio?=
 =?us-ascii?Q?/W6ZAI/HhC/AvvnR3u5BtID65z3HoE09z/XP3DO+xMEnPn2/IktveuxQ2Ltb?=
 =?us-ascii?Q?CQLv66bMyC1+gbsrZ6sA06+UrqcrqxwxNwKEyxfXBUNEpQq8YnQz26bPm27z?=
 =?us-ascii?Q?JSMhJagHWI2gmyZj4DejqP9GCb1s+5aL1LzXy/e6SZZKjvbiYWLsnhP6x5Wu?=
 =?us-ascii?Q?nDvp6KhOccvFkBc4y5wtdEl0bimslGyK1ySO54I6MRjFr0xBkveNtaPO5GCJ?=
 =?us-ascii?Q?ZgPSdwppEtQgTb4Ju/2jh8dUOw56NZgeF4so49y7sNMbyNFW9YNv5H2q6J2I?=
 =?us-ascii?Q?nzRlSUZpkWQ3LB6MsVA4KxT4qj6zU2HpDMR/7W8HZ0pI0v49CBMjC9nr7tk2?=
 =?us-ascii?Q?ra13858WHQnsuJPY8GVuKJBLH5J481S3P2y2/ngp4i+eP88RLqunovqNFs7c?=
 =?us-ascii?Q?S9Qi5lO9OofmgXFz4Mrpu98UTljxLpngadzauzZcZMa2bpBJBqOIn2QSI9HN?=
 =?us-ascii?Q?R+GDqUb3kLVOMyB1jkSEY8qvb2VZoWneqPND5eTqCoLefuDfKQ02OFMoH+M3?=
 =?us-ascii?Q?upigU7pxbMK7t+bhwsyb98O12cM7yV3GpvtWQvWB6rwuBTN4vbpezi0STn6D?=
 =?us-ascii?Q?gz4q5/kn4fIzz5kbLT308xmXTRhsvv2iFw0IGivT8H4rQORnn9FRAxZJqDnb?=
 =?us-ascii?Q?cVouXi5br3wI+IpXADwoT8Qf1jJl239iLrKlIUEPH4Yb1u2knUwquQQbtcnT?=
 =?us-ascii?Q?5sgmdcUiaMam4oqnS2MGSS0wl8w+uSySKBImj2tLZ04U3DsybfPVpo9kWaAK?=
 =?us-ascii?Q?i2YPi8dHTj34iL/EPxGK5y2JyXxD62a92d+W/mpSoLvZcKLvAKRvXhKVLm+b?=
 =?us-ascii?Q?YgW37hMFy6V/UeQBhGfkTi8hNBUzdHQCavDGmwPxdWorvz3XuZ/JiTQZmSEM?=
 =?us-ascii?Q?UqQhZvP3xACf6tOTwjfWQVdKdj9D+KfUqxOhrHUDL7LDO3Y7rX9X3SAa1nOP?=
 =?us-ascii?Q?TySY2LAZCp8XZl1Sohay8Lu989X+dGdZls3pNmY65PPhgg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6524F0E7030D6F469C8149997AD9ADC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7625572c-3e1e-4148-37bf-08d97d04c300
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:36:05.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBwZFrbI1h3mK1zArVAt1Vy7Vdifr3dYKkJx92NCAWHrYNXQWCF+4y4jGMZL+1TuO+nrUlCeY1TebDlPcqmB/pTparXdjhin/AU6Hy9AyFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210083
X-Proofpoint-GUID: 7NSOkoF2eKtoJFQAwayIqLpeT0X2hojY
X-Proofpoint-ORIG-GUID: 7NSOkoF2eKtoJFQAwayIqLpeT0X2hojY
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> Output defects can exist in sysfs content using sprintf and snprintf.
>=20
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
>=20
> Use a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done for dio
> attribute.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 63f64341c19c..fedb8d63b4c6 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -882,7 +882,7 @@ static ssize_t loop_attr_dio_show(struct loop_device =
*lo, char *buf)
> {
> 	int dio =3D (lo->lo_flags & LO_FLAGS_DIRECT_IO);
>=20
> -	return sprintf(buf, "%s\n", dio ? "1" : "0");
> +	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
> }
>=20
> LOOP_ATTR_RO(backing_file);
> --=20
> 2.29.0
>=20

After fixing small nits noted in patch 1 you can add=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
--
Himanshu Madhani	 Oracle Linux Engineering


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A920C4321E
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379182AbiDDVTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379002AbiDDQRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 12:17:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3631922
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 09:15:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234FxFCw024455;
        Mon, 4 Apr 2022 16:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jbuTnKZDixp/NcSOh25Bkuw+PYjWrao520+g+Wpvhec=;
 b=MgLE3gw7+dKaYAf/NRQZDlZBov/0HDvZqOofTU8/+OGZCuBrE1pSLAMO34keD/wjxDJG
 d8jKRTyXq3oAgaMt98XE2reWLhlsp2H5RvZGWU1ayAb5ePOKmp5+4usvhhPAoK8ooJGc
 KIhR5N1Y+ItSBxz1JTY8uM0rWvMO0rRtM3PfS7fwmfRVBNfzMfalp9vrUp1x95i7PGwB
 8x543S+yp98JEHPuPizTljj2QdZJEESDWxJlVjQ8jOEh6gKGIX1JHyg+vYREpYBvw5a3
 UWHOAVeVgdMVNbG3pbu1YjTZ3bbCNACc3/N2en0W7Y64dfx9vSmTys9syD5pLioTXltA UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3qm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 16:15:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234G6jtl021602;
        Mon, 4 Apr 2022 16:15:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2n2v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 16:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6AWyNTB18OJrFt8nBrJQ9sb723yBWBW4UyuKK+gC7szaruBiJ7UaLKuT0+AaWNyrm7DMFR8kajDzH3iKJiEyDSqCDwabPSFgJlM2r4uSkWgLz/lqb7xBA1BlgIU71AjqPOfWuk6YSgmVxuBdJa/TyKReyZ5cTzOts8D6JyK7osqvyXmiUAXBQTPXEhy4TRQcmP+ZT9KjD6WP7o9yRotjCqV4qMdE/L3Vr7Bca8X4yQ2hrrP7B8tcN5oZftSzM/32HSjnUaeZDzxSVxqbkTTTTt7XMBaAv+dv2kPvyQVBFt4jCpFVICWqDaR0HUpRmX4Ln6dIRBVXU6npPpY8y/D7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbuTnKZDixp/NcSOh25Bkuw+PYjWrao520+g+Wpvhec=;
 b=lrbtlg4aKiG9v6c22NS1R6u8Nij+saXdiDEr5tXhzdhQwFMc0OFdwwhLFXK5LzjJg2QuDt3KWGDUjN+nC3PKtEYdYyW8mQOv1dd6SkVnX4Hgg+FYCYXEcsTzVOExu1RUZRsv/Ms3maoBuALYXqycmiV/DiEac1VQhIWilIgSl/sP4mwLDkXRJ1dsO6TTtkz2vRE/q7barDAIaZzHuhFhK1YGTTFzJ6T1udeK2jmTdLabBi4HArf9yXKL6pWyM/aSsos5YXSkj01jjdL6lKHXBzS/u1sGwK8lxb+jPCFZqiFf3bVyo+VjnvEPQ4mK42HVpNDCr2u4mzz1f75YZoRkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbuTnKZDixp/NcSOh25Bkuw+PYjWrao520+g+Wpvhec=;
 b=l7fl6baQx2v3dXO4RfIOgCgkeFkz3LDrGdOFfrCgYXioVtANn2jsNvo3k7Sxvb7nsDHypWfNvfg4WyzxtL7i7izATS8uUBJD/ydxLuOQ7+I60PuJHVVmQS94i42URgpTIk2NHCG6i2EDgikAqI3EzWSrIb10d+RqKLJbHrPfEOw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by MWHPR1001MB2111.namprd10.prod.outlook.com (2603:10b6:301:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:15:07 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:15:07 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: Issues running nvme-tcp/rdma passthru blktests
Thread-Topic: Issues running nvme-tcp/rdma passthru blktests
Thread-Index: AQHYRUjB7B8SuGFkOUKkBTNdBTVbSazf8qSAgAABFQA=
Date:   Mon, 4 Apr 2022 16:15:07 +0000
Message-ID: <4F22343D-A75B-4848-A500-8986F40E4C8B@oracle.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <19889C9D-608A-4772-8B43-E2E4B118D801@oracle.com>
In-Reply-To: <19889C9D-608A-4772-8B43-E2E4B118D801@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f33f3eb-3c6b-44cd-5f29-08da1656491d
x-ms-traffictypediagnostic: MWHPR1001MB2111:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB211191375B80E2F036385F05E6E59@MWHPR1001MB2111.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lrqhmk6zw5qgLu1te1GkDvID+OtrtXcw6yJiJKaa7BezUXpbogAWbukiQTE+grLo55tN5aTxrfzxTbldYh0nUiI/w+/BDyUsTuM8NB/B9Db7pXJKSyWoKW1nh+n0Jq9+uAqHMRAdIjiBq9hUhAPS7cx20pNCgTaKsWD2qryKjpnFDtnUdVKNaKA/HuiE1/9r+JOn+lbIYMTmBen6ag/0B2dGS4DNRTs+wrNLGmIZVRNz0jf+FPc5+xw1AfjVrmV8xnz6oD73ojVlWEqFLasdZu9km64qOJr0kiHr7gkHxGAMTK9bzMHIEc/vbyc7aQD+XpcsaMRLv5p6jXiy/Bw2ddlUQ1wYZngyLiNq2hMnU//X6x+9Rf7kju27kvr3H1liwSTdYWbSMQjLTcUka+EWIarGupm/ZaGFr/AfO8QMI1RRPEbpQyIyYuxfLn7so/6NPoeVgCDoEyoOm0JusxbagKjuFqLEYqeJLW9oEgT/mBjMwH17keFqEcQ20R4RNOmaj9FlNm23rQ1Hd/AMNbQ5csWw1uCuXoeF+c2459fFwnLALT94FZlhgk7FO4SS/MIO49SW3xUBUjnwi8xGuxWVBOV2Rsp3dcaVG94NmXok2VxC4fdzecXO4R2lixZyAIVXKsenCVY/FPHgQn4kzjxOye4ZPTgj6GfKs6ns4km+r/TSmyOaJVjfrO+Or8bvMrkTtfId8sA212C/u5aOaoGiqLSTm/2mLvO9ei55Zk5Ds3a47LS8jIFiHZWyZLav4uFi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(26005)(186003)(5660300002)(38100700002)(91956017)(2616005)(8676002)(83380400001)(64756008)(66476007)(66446008)(66556008)(6862004)(4326008)(2906002)(66946007)(76116006)(316002)(6506007)(37006003)(53546011)(38070700005)(508600001)(71200400001)(36756003)(6486002)(4744005)(54906003)(6636002)(44832011)(33656002)(6512007)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqCDBrrZKWFVxbWVR4ylofCtRbADP8ZACf4bJvqAPK+2QT4JlKEOQB+jot26?=
 =?us-ascii?Q?Ipfs8bkgXOmJzgl9RBzxVA7wk3WRLu74x2YmNkgZxUF6UF6TaYgcgIClSCAR?=
 =?us-ascii?Q?5KevH7JxeI/4tWnO/U3FkCIzyV9PvLXtmOy0ZGEO/3DyGErlNWCqnb5MtCAr?=
 =?us-ascii?Q?iaVaWTWjbdbKWEX2WjLMdmBZ887lv/QSKPhf9pp0zqJ8U6TypdD7d0xYTMOB?=
 =?us-ascii?Q?8sx2jal1MhLBcOPF/iQwGxqBheGuOhFNFeXKhQN+YoY9zLWMlMItbBgufdJW?=
 =?us-ascii?Q?lAkkpLd9bUEUTbYk8ofHPPr/HcsbjqM5EUkfXhIhfRzmxz/ddFCmbI7wh0ip?=
 =?us-ascii?Q?YEK0YP4E4KMYN3EdWyG3o/Tth4XyxcK3ydF/CIcrnrQIuGaY/TDgDHIkdmiN?=
 =?us-ascii?Q?L56XeyazceqQWMAqG1B4JKaHV65nlwsKS6jWLzZ2yvEdJEdpOHMOXW52yRy3?=
 =?us-ascii?Q?C66LkcLJgUa8L9wGxGZ+CRmrMwcn9nBGNqPHcfYAVUVurAvDw+0sjBwcLChy?=
 =?us-ascii?Q?DkK2FtyYM5vhDivWRpeNIBTNzwufkN9yqwbit8CAXkLq6HO2A4JIOmpjfQvO?=
 =?us-ascii?Q?f8047Gkxyy55nEkO0PkGNLEyG4h+WtW7LO4o9O/OmxsAq0ZM4rTAzJ93GCMA?=
 =?us-ascii?Q?gylKkolBmfsYzVcBNNVOWE5Fcro02/5o6L02rVx4M4bBWTVd/UsVL+jNZpco?=
 =?us-ascii?Q?O0E8ae28hjZWvaLATgpknCUT3/C+MsoLRvWcjPoDLcwV9Mh0+QRJBsAR7SJ/?=
 =?us-ascii?Q?byhrAHIuAaixFovFhVjG+1JS5vqAr0f3dEiYJJ9+2HAJvmG3DZrWJEbT94JL?=
 =?us-ascii?Q?9me2VxwvYj7ESiTdFbtQvs/RS5APQi/Dw8dPY8z1qeiDhAJBRSL9ZCH9wJbJ?=
 =?us-ascii?Q?9k7IyECguqCn3SaWlNjUnX4LrM+snXGMWQ4AjxpHcJm2XeS/X6eTQK6VO6CH?=
 =?us-ascii?Q?hhkoi2H5Rz/QRtgEwbOzlb0ySdfsYwm2Es503CrKqHzScsXYKVpsyTFq4jAA?=
 =?us-ascii?Q?ZxXiz4y42CtevtgYETDZUpQYazzwEObf9nfHTF9C8/5w2opFGdLKDntlkK1C?=
 =?us-ascii?Q?t6EV+K5J3MMki8ABXBAwR76OppkDzelS2xwlObr+Tg5rcFiWh5D7hZ9B98Sf?=
 =?us-ascii?Q?mAuJfdC5BKr8HmnSXUGIfUX4sZS4FC1BwZDDvPu6JV+hdizcfBHYCAeAJRuM?=
 =?us-ascii?Q?3ZhOaRGq/vkfwadEh1CVNaU2Y+IpqhfN1qigVdTdD0X7ojCexFvPsBkcOroR?=
 =?us-ascii?Q?u8toDJ6KIapLW+x5jZYinUlLvSCUSGCe4a/TJO4t+YhTZjWFH49sbilns3gn?=
 =?us-ascii?Q?kAAjq4BbgfTgCNGNQAir45Mls00excsoJJxgmmA3Y4g6Qi0A1MjkJH4E2QRk?=
 =?us-ascii?Q?qpTD8IhT+2wdwMrEg8Ru+1N3zls+3txdPlIZr27no1wq/PyODvGjcjxrhamH?=
 =?us-ascii?Q?hYUXsj9Xsv5eJYcZlhsQ+185ZBtikTiHZ7Cu6tOcJ4qDMp8/idfNaB3uyLxg?=
 =?us-ascii?Q?JgfjTukkuz781KnNpkG4F2BMsI12xPdL2oMFxYDtqze4AUkX/8kwm/sd2hh0?=
 =?us-ascii?Q?CT0fUZTTspJfquTpFy6hZJfSmKyrwd58APYeMdYq+92pGlI5804byRYSoLB/?=
 =?us-ascii?Q?BlOQYA/44kcAix14ijvo/M+qW6+bftQT2K867zz6ny45CxTsv36++ZOgVipD?=
 =?us-ascii?Q?75Oo6YdUfpdUWt2Zj7ZariL3OpbewyJsmWLYEaeZ5WljmxaFeJZTr7slHitn?=
 =?us-ascii?Q?sf4TX320jXlGiTDV9QgfsNIhYUKYsv7xAckUscWZN4N2w7/oLDQJ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BB3A675E8C3844697173913EE76110A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f33f3eb-3c6b-44cd-5f29-08da1656491d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:15:07.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FQ9CJFuoRjaiYghpb5kGPXKj1Y4QaDbcYBgPN2akceiiR9UzuhFKWUOPAWtGjkwCRLpbT4VrpqjiMercBz0cLQc3nTLrc3t78uDLGZSk7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2111
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040092
X-Proofpoint-ORIG-GUID: K7H0Bc4EKOAVaBtN9W3nyMagEVQW8MFv
X-Proofpoint-GUID: K7H0Bc4EKOAVaBtN9W3nyMagEVQW8MFv
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Apr 4, 2022, at 9:11 AM, Himanshu Madhani <himanshu.madhani@oracle.com=
> wrote:
>=20
>=20
>=20
>> On Mar 31, 2022, at 2:45 PM, Alan Adamson <ALAN.ADAMSON@ORACLE.COM> wrot=
e:
>>=20
>> When executing blktest nvme tests with tcp and rdma, and with=20
>> CONFIG_NVME_TARGET_PASSTHRU enabled, tests nvme/034-037 did not
>> complete.
>>=20
>> This was because the nvme/rc helper for setting up passthru targets
>> hardcoded trtype to "loop" which resulted in the nvme connect to
>> fail.
>>=20
>> The following patch resolves this.
>>=20
>> Alan
>>=20
>=20
> Can you resend with the patch included?=20
>=20

Ignore this.. patch showed up in my inbox. ..

> --
> Himanshu Madhani	 Oracle Linux Engineering
>=20

--
Himanshu Madhani	 Oracle Linux Engineering


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01DC001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjHIQ0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjHIQ0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 12:26:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C6F1999
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 09:26:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379FAgjN031101;
        Wed, 9 Aug 2023 16:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wnup26ey/nnDc1K+/n876m07ADXnwXIcuFTEisoPa1k=;
 b=Z0lMgf7s5K7VsxqxxAh+CIE+Ij74pgEMTvKFwltUsnt1WVdq9MiFBJzP8EmrRPb/YEWN
 FokSbe4q1NloXHpTAnQclIVwJT1CyB1ozXPJ9tRgV7wI5G4ApiSgH/49L+mX95Io0Kmq
 +5HUxs66ZpsJoS2wvgFYTfpgBd6vdyvSoyxVdoOiSpZRmFPFWmIN8gsYG4CvCDaoT6ve
 7+BYpHTN3Wuypta3jFVr/is29KTW6OhqzQialVPwLUcHAZ/6vhYY+r0YMMR8quRuZmQT
 DQRpLt3p8XXra4j0Xn+hI2OiUQL2R4toW14Y9ELpngkQgZacxfIpda9KZsH0KY2nEcHq 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73h6es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 16:26:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379FsbX5006379;
        Wed, 9 Aug 2023 16:26:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cve8ufw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 16:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhsVB9s5k3VgtuQri8HWBuKLn9s+EcPLI8kTcjTgu8L8PlZgfTc9A/3W48pjanQ0cPZ86QY7TC4qieFLqIb2UYM7G/TS4WExUva2gs2Rj6Jnkz2FyHD0/1F+e0kuZRZmYdp50OiuZ3yiEnpU1WfD5LLCM6+d0bv0iZKJxyjsghU+Hr8Ma9J3Cp0k2wn2xQqvfmkHWPwS4sZXlW1MdRa/C59HoDTQk5JTv5NjVb0Cd6cHlg0iX/lzaeZUPEPxINb8EHhnIKB58XUJpH+Uk9j+LbPttf/3V+pvC/iB4PMJ3uLfIaGh7P0NHdCjptteZXniJHDSm6MtO31kgFTLqgltRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnup26ey/nnDc1K+/n876m07ADXnwXIcuFTEisoPa1k=;
 b=HhbP/gjgCJ7td5ggScUUKlQJ38ObB2pv1cjqIr3+NnaXyrv89cmvmaZuDLgJt/kYJ+gYtOPefpI7ffS3C3syvY1gXH9nIH6OvMncqQPZkiTBJlZ3yJ5/0CBYYXGFH+0qLS8RpoNSn2sImCM2vVcAY49HRAjPhPTNJN5+NKvcRkdUueRKuGJ1Trnog4xvkKAHkBKE/uC57z8WDaWwEzLxgA0USG39sipfiOqiENQYTFJafDYBnGEJFj/76H/Ts8fppefLdgtdehHsYgM7x5LvHg0m1PijcBAHmStdR3i1qcDaO3bWazWGtyTnlR6WfvFIcfjUDkV61DDhvWYGa9O1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnup26ey/nnDc1K+/n876m07ADXnwXIcuFTEisoPa1k=;
 b=ArDme2XITgs6tnaw7AGg7aPqbmHesMqtrwAMQQjT2tzLZNmp+jDS06N4mGlcJbWY9DKlgUBGI5SN46zmxk6yLzl1NS3f8p86BuxgehL4tx7lQqvutu2rDBUKJ2WTQgOP7ghL3mMz7rPytOWZ3f+9rFMl96Y/zUSjWvMpvG6LNjM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.28; Wed, 9 Aug 2023 16:26:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:26:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Thread-Topic: [PATCH RFC] block: Revert 615939a2ae73
Thread-Index: AQHZysKon/4tBl92N0CaQb4cFhU7aK/iHSYAgAAFh4CAAAQ/gA==
Date:   Wed, 9 Aug 2023 16:26:27 +0000
Message-ID: <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
 <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
 <20230809161105.GA2304@lst.de>
In-Reply-To: <20230809161105.GA2304@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6030:EE_
x-ms-office365-filtering-correlation-id: bc35cc1f-f063-4224-ae2c-08db98f56179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9oQltqwjIA8770+xRR2WihBQV7PHAeWp4H6LztJnjMQFBo2fFJ+9VbhmnfL6F7kHYj9HUfkPD3MT1SjLF02YlELaRBFjqp8Ieu9CC5MVs4QHfFV/NpvMdpUWE5kueLg3URc1gQrV7/rbmtr7SKKDTOlzo1rKyaXIqQpo5MJuCuno2J/E2qfYGha3KNP/w1s0lIIUeES5wmwkkB9CJGKKYJwxF93Cs6XN44q82tyTqxxyAh7uiY1ZlgN1uEgEaOdElYs+75x1egXo36ADkBsyzCShX+uWtAGI35bX+MsiRRR/x9Q4wjiem1CXMK30G4tmqLdwiKd+AB2r1kMCJjq6qu90OYaiWuRfJ/r9d2WihenPdWl6J0FJgO0juDYZXk8orvJlOiOSU6kvuAafSlD+2CzvenGzJ8jN8T88GlsyiFYtALDMWB1kA3cA0YQNpSFj6khbAS7madM0oVp3hzTucFIROUb+7cPg1PEYdFexb/rEsbJBeaVs0vlpRjv/58+Il50jdOerVjQR4RsSJlcD7SnCUnItSF+c3EfYTedUjwNNwK1woe6EyOzhH+8nv+ftuFpuAKewvzEqSpo8bP5xwJXz03g5i7xUY0sSd0HmnAt6HCfxrE1C6fI5/CrMuvD5rmAVfPuHnpTINxHPYrd6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(186006)(1800799006)(6916009)(66446008)(66476007)(66946007)(66556008)(91956017)(2906002)(4326008)(76116006)(64756008)(38100700002)(2616005)(86362001)(38070700005)(6506007)(53546011)(26005)(83380400001)(33656002)(478600001)(36756003)(122000001)(6512007)(6486002)(54906003)(41300700001)(8936002)(8676002)(5660300002)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ff7gkAi/EACK+ljHMrL5KjsduZCOYQN4bqp9gxL31rKtzx/XbdVOK8nFMIHa?=
 =?us-ascii?Q?wInUgrMaeT9E61w+K5gr+IceXI6sqO2KwktmQuNpF4rSQjoMikFSsFV1qrPM?=
 =?us-ascii?Q?4f0B9MKN26kIHPi9i/+Dla9gkbcLqyTk+rzuTXV+GqGL2YoqB9O62imXoiLv?=
 =?us-ascii?Q?GuJzuJ/XZQ2SOinNwQIOTQVZsJt4JS8LFaKOsMirJmopTsQ5lZHrJNhf5VJE?=
 =?us-ascii?Q?nq2Xixlss5ha+BlBHA8O35LZDLoIaYkmZk2+xjLC7ue5idKxfswVpr7k9fyV?=
 =?us-ascii?Q?g2xPq+GhjMBlsN3oM82QSa8jAtPTqz1BLXdrKszE+xFLj1vxri2YXLtuX+Wm?=
 =?us-ascii?Q?bct32dK0X4uQErrBTeG2wQrzBKPitRs80e2qJaXQhLeWiTP3hOkSzL7YTYfq?=
 =?us-ascii?Q?9RVUuEVDND+o1XWAT+Nz6tXsYBIX0PdWmm4GhUd7TRPaq15Y/lOM67/MJ/Wx?=
 =?us-ascii?Q?W0xphubroEeQrQ2xGlJAfzE8M8Sy2enkHcDKns6Ip+0op7jWoPeQAet1DfvD?=
 =?us-ascii?Q?5MrLpkRZqD7UoyMiZuOfnUUQOC9F+rodv75SvHtMh9Ff3uErljFn9VUNv8bn?=
 =?us-ascii?Q?WCtYM20OLi4HDGxnti76TzAVvHHjFOXm7PpB9bbm4MsN/oAaRU2r2kzerUc7?=
 =?us-ascii?Q?xyrsBNd2IqnuTU7huXa52/2nk8HAiMGJALjIj6wLW3/2MCULj6smauebVloa?=
 =?us-ascii?Q?wdQ50pAPyXaPpTxuHqSJYYgYbnCMvZt13JtFFWw+CWmN9MiqtFVdVQtjBTua?=
 =?us-ascii?Q?HxRhIpqEH2TjTtkrX/6ACpgqGudLw4IfANA0xUZomYNF+Q2ttXMXDKVWGhM/?=
 =?us-ascii?Q?l0CRH3cOlA/VGU6xX8T9MpCwRFaBabUzdY31KTCy/F5HQmshA3Lsv1seWXL8?=
 =?us-ascii?Q?53Y+H6Ehd1WQ5CeMNAdSss8lFjB5jPoujWmceXExzbdu6dDwV1fwv/4Cjudv?=
 =?us-ascii?Q?EvulQiOWrvSVfktIR9lda0NReytjZeynhwp+THDuVVdX4DMpAXccPb/76UuI?=
 =?us-ascii?Q?2z1RlD52p0PQCqmLFpwaEu/TAjcpLTKKMf8Esya5vqoEzK3c2DfekkXKZwMj?=
 =?us-ascii?Q?p7Zpzj5xNPYqvEFZSdv/WLI2zXvWn4ElvvJlHlDF5jRU8IZn9FWT/BrQlFFP?=
 =?us-ascii?Q?02LsN4mlbz+Q635B/wJ+LKeBD9HqUncPA6cDzY7kvEKf2DyoynJ8UOsTkKyc?=
 =?us-ascii?Q?1gmBUR+6pzxTTT1Wm7SUS0uOrWnSCNdp8AxphDv5gNSi+JuVKFB5dH9rfnOF?=
 =?us-ascii?Q?7NhgofzRCsAmgDbndUlga+aq9sBMO20ZeiarabySLaiTKpRSsnc6nA4pZysA?=
 =?us-ascii?Q?zNTskUteomE0St6uVUXS8VUt1uYxMF2dWPsXVqNk5+sZjrdN+TTn8fMhs3EI?=
 =?us-ascii?Q?ezf9WlM3Q4X8kQzbZZ0P3n9NGgqfvKaQkf70tC5zSFfxMGfrLx0HzZG6qz53?=
 =?us-ascii?Q?DCY+93tyfwvGiIsd4Vw7g7Lhf/CSlPXFNSITwOiwuVVpHRn7y0IS4mYWi9qw?=
 =?us-ascii?Q?RX5z4a4AIXuiPFqhy+eT+lDSH24+4TXHAPsu+YdKhSigCavyrLuyvQ5jQZW4?=
 =?us-ascii?Q?syki9LfOL/eTFLz5xcnI/DbgqB0WA2BDD+oZ5LXTmNlkwKBtynTV0kyYt8dn?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4620CE676C30554C86D8276F5E50D0F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uQpGSfWkLNf8x7RTkCzsnKLI6dPySqKswUSSec5UaJLHLT47hFTx/1ClnnqMomE6TbQ9g1JMI47pGmJJZE4TmHk5pi/RT+l+ZQq/a3bh0uomifl8s7/VuHp9Hxjrqyy6hULZ6VBjBGAvCLoDp6VPj8ra+2YErs+yxjod705NIFPRvpF/28TEiu98pd5FWtaq5uIy6gupH+nKxHdIg/nfZ+badsNnCQThgWYc7lY1RIrSwWNBOcDNJyw7Zilp7xkEnyom4iM1Kr66hvp81i0myo1KhgyMsKWJfTolSo4cqbKuw1diBApi8WH86QCpZMG57L2TypqGVnSvdvBfDhlUBFpbLtJYF1y5f0R50cBb2hM79r8Ro7+DQScyNLUJsDkgcoI5Lv0err/3vmyittGwJRKk/N4aRjB90c49/ybB148Jh/Tgt9t0lMlge2yRxpD+nP7AAvKkJ/zgxqns0uAai7+jLwX46kEPJc89UbCkXa4ivrA+xc3jSGdE57M5nrnoEMIgsyz8j/Jh/xUtrwKmZTbnSfHGCHE6Lk+9GCUXir/VyTNbA2Xlaqw20URo4jc9CK4ezgR0a/BBNUSzHlkgWIjpC97szHzJ73QwOUH08mEenU5+hYjU/+li+uMELr8dLVhlSXBS8dgTIhMgjfUz3AcZJ4flagMH2wmxg/awgkuH4Gu7gponhbc+jcnJppCyiSO5J3sPJXH6XraZ1UswDoLqJt0C/ggEQAwGXx/XjAB9Ho/kSpnEgTIfj9lT/U6JYFAthRWSqg1eALSDOzDDwzZmXqzFTwLWBqE4v5O2+w8vS1Htf9WTXYFhS9tJE/3+mTQ4AhXOUkQyekGDwlUesQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc35cc1f-f063-4224-ae2c-08db98f56179
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 16:26:27.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwcVhyuxmtb6dAyx2wxZGul5AA58w+hFhEzfa4pIDY/X4KhsT8CkbqgpVPt70GNWES5G+V6xbD06UwK2cjtNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090145
X-Proofpoint-GUID: uG-39n564-d9G-BVHxhgcrF-4XeBGiZB
X-Proofpoint-ORIG-GUID: uG-39n564-d9G-BVHxhgcrF-4XeBGiZB
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 9, 2023, at 12:11 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Wed, Aug 09, 2023 at 09:51:18AM -0600, Jens Axboe wrote:
>>> Bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
>>> submission path for post-flush requests"). I've tested reverting
>>> that commit on several kernels from 0aa69d53ac7c ("Merge tag
>>> 'for-6.5/io_uring-2023-06-23' of git://git.kernel.dk/linux") to
>>> v6.5-rc5, and it seems to address the problem.
>>>=20
>>> I also confirmed that commit 9f87fc4d72f5 ("block: queue data
>>> commands from the flush state machine at the head") is still
>>> necessary.
>>=20
>> Adding the author - Christoph?
>=20
> Hmm, weird.  I though we had all this sorted out a few weeks
> ago when that 9f87fc4d72f5 fixed it for you?  What is different
> in this round of testing?

I don't know the answer to that... I suspect that I originally
tested the first revert on a kernel that also did not have 615939
applied. At the time we thought only one of those commits was
broken.

I've bisected this every way I can think of, and both fixes are
needed to fully stop the hangs.


--
Chuck Lever



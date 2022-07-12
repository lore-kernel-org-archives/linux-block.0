Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD8DC43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 08:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiGLIxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLIxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 04:53:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68305A9E44
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 01:53:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C8BKPG007080;
        Tue, 12 Jul 2022 08:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=wJsbnyPjN/5nZ9H4uUUn8sFU3tzQjcpfvTfwQFDTSD8=;
 b=IOyi8rzO0fnufLWt3M8jH2hs6CpCTpiDR308ZoIc4r7DrV+oJKpJeoic7q8SlOoWzn3L
 ZEsMIEmj1bJkvZmOPk23OpLbtd0X7p2VDy3F2oD/IwNLW6WEoqbI6dksvniIuznvT4qX
 91L8WNCMlIEjIPFDrkPn2y0qpiy88orCLIVKU8wIJQClCTlgTVAa34IalSlzGY5t/KA3
 76rwden/MlPh4hi43eRmivcBfjJjhIeyUcRnoEpy5LVXUYVWPACj2lp9N2pg2S2NCBbr
 wIRTtPTh+eHUJLuVFqECWgN46SBa1SzVzjOq+Cwumum0jAAVK0ZdZURxwjlBwjkxLCoO yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc64bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 08:53:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C8kaZe021662;
        Tue, 12 Jul 2022 08:53:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042paxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 08:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEcJo/cOjS4mw9KAPe86YHbXE6MPTexESOs6OlEvB/i3eJoE0I5y1xJqdW2TL1hSSMci72oSGqsifsNngNYcgTGl85SRJXTm88D5ZfvXdkSyZAQtP5s0kt1H4Qgswr+1KusFPvi5nnwya5a2phFMy9BrmoloL0w4SW0v/gxEZ/BQehsbibRpjVd+1LCyEhoLwKLCRlv3mMiqlcMlb6BteG4AI+ukr67Q2g4ne+87lot0H/AmGL0rWx90MFOPnUZ+egNqDZKVAes9/Ztuz3+TfNBfrNH4HMObsrBaFqGb053XyVn0Iqi1XERH1/p/W4WAF6JTev2CSEL/efnIOOngNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJsbnyPjN/5nZ9H4uUUn8sFU3tzQjcpfvTfwQFDTSD8=;
 b=Cju9WDW2v2IKjzx5VwQz64MPKEltLbZBiHoX+Xj/PM+pU/ajRhILj4JN4fYIjJk9MbX9rIpowCFxpItpcJDUbxs/t2fI3AQOcNiazlKA46qmaJx3/tL02NPEXdoi/PqYgSd6CgQD+UoP/gXMSZDzkkhMHVz8zZH5/bM1dF+TQ4JqlOYayqQwlgbbq/SBk4AVovUYbKaKwi4aiOYl7Vn5C9S6Gy/IdwWb4YNsdetbRVSLkqdQKmQ83eBtmSthj89TBCqE8S+Fo1JXVH1YsxNcViLBQfUfFTI4KQfgafMJ9aESX91DVn8SiqQDjlSqvNiTFXlqadYgLpGX5B1N4VDBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJsbnyPjN/5nZ9H4uUUn8sFU3tzQjcpfvTfwQFDTSD8=;
 b=sYUX79dZwbrc/yFxGFbZ8SM33ZJy+zIl5A/bwiX9S110ZQuRcw/zFRmIXT66uBLd2akq5KIVgmO/0fpbM9CRi6OKdd8p2v8LUwL0pBudncuYgegdlrLULw0LyF+ovN1P4/LGPvTw4nv8MDa6ATEbI0Tq6UQTsv2kFRuunhnKKJo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1531.namprd10.prod.outlook.com
 (2603:10b6:3:d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 08:53:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:53:02 +0000
Date:   Tue, 12 Jul 2022 11:52:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbusch@kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block: fix leaking page ref on truncated direct io
Message-ID: <Ys02ZQ+ekH1b0Dtl@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 771c68b4-5a72-40b3-825a-08da63e3edd0
X-MS-TrafficTypeDiagnostic: DM5PR10MB1531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rieUmTSwuViIvgvzWvLAF3B2UqoquQRdc+BUb9f43qlN8HM8nmbpiN9D/uuyZhla2P/BCyExp4kX4JvFjKWfjCpJef478K/Go8QAUQvkX5WmxNbi28ejtV3LUlGtVQBqUk96jAcQhsgb38WDsKEuXhOs3QurWQeXilXkIH9qkmLkh/N44J9l1bv4s97/msrmRVXnBzk6bPfKfY2lxhG0YlJRmf7/Cog6UC6LdAqnGZe3rpHPb61ZpONECIglwC8B8OJbChBzJebHwYpvZF088xZc0MoEl7Swqkp1JYbtEPKZAk1I3MqdPnzEgLOh7QLOONrr31btkiiiihFAVlen6sZ+I1j9jHzsvw1aVpa/re3nrZIiSkOrZ5ijQlQFHYh6gUpqBNg0tIJVOMiQuPH5KleUf9nzf3pJvl4C5cEO1DnCcFbEEKR72fsFTrpLVASDvKFk4lhspYk3LoVOmIY7wmn/TiHnjcpvuGJ2USTegd3DZ9chb/9mp6GwGcp4Rhjy38XwKrTKz4pvp6Bi4tdZUm1lmuxgZzeoiZ/N2k7PF5j+A/hy4hsO0+sBMSn0vt3Ckr4k2j89Yl4kPTEIYBePOlmpvjIxeDJ03GnUv0IhxCbjomTgmZ3omr4P3ekHsRoMGvtI/bdSvP4D7d7Z4Sds0kz7ZcQPn7zqOMxwucl+GJdRxvpKPTqEL7leDlL0GLGIL9m/UZMnsrcu7KjA4qr7l7cTPDL6XVOE+rK7j1AXD6wz4+HSuR4bq6BYZ3Tt33nU/VbVfBgI4w7M0sqq2ZaG0TcnxAF6WFkW1rAM59SzhrKDI5GfBlEwnRcoMqSOn6Vb2RhDpzZNaqcnfu7XnRiqYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(316002)(66556008)(2906002)(6512007)(66476007)(86362001)(186003)(478600001)(8676002)(5660300002)(6486002)(52116002)(9686003)(26005)(83380400001)(8936002)(6506007)(33716001)(44832011)(38100700002)(6666004)(6916009)(41300700001)(38350700002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCmTiDvjM6GkhbQXC5xYa2DmI/U0kyXhUuM1Bj+ukLNoCtFkcUbMZOfXbe+j?=
 =?us-ascii?Q?MSODqgm3vX5TSHQ/75FNYGexNHklxNZOCfwDOA41zIOFPkdBLz1VHU8JMSdy?=
 =?us-ascii?Q?TepUp3qDoB7eG5J7xt9NG0hHzf2nJr63nUTDeVQ/Nl/byClpBEWK8hm3WoF2?=
 =?us-ascii?Q?ytcfhTVw0ZJXh6Efv+xZvwBu+g25P6WheuscSgD2/mJMI3K9rHn0hXkOILqc?=
 =?us-ascii?Q?67D9TGXliTMk3RWlUIq3YKEgLU50vmVUIHDk1uWWhDeAIQXUWHOb2oSbx4d1?=
 =?us-ascii?Q?R9U3naTgPy9RQ8BTaKFFhTdBZrbhX+S3kFCUywrnWHHmXs243vqVhVnbpXxN?=
 =?us-ascii?Q?KG6Rj0AJ8Gm/PfScxHlvA3WmfFs7V2OygxdawNALj8jFUJKUJTk5WLiFw2VC?=
 =?us-ascii?Q?J0AuI/+Hg1JHP6Uc7aOZII3sJ3yJfLVvQq4zeS/tie9Ieezm617OSZ6EvX24?=
 =?us-ascii?Q?AyVh+DldY8lYMtX4JOfx6+v4YMIOobbQhCl7AoAf2RNjE9DhMrwaArMFTP5N?=
 =?us-ascii?Q?08pSeIwKtsQI0NlLCDPIUJkqFEEvxAjEJkWKvZDq5t7DEcuH++sSzk3RsbZr?=
 =?us-ascii?Q?0X+AEeyM+fCtPkos3n4gL9ajytdYyOORs9LmzjBIeYowKSAseb3WZfrAHXYs?=
 =?us-ascii?Q?wUQZQV9zDgVEhkyZ8rD5cQEFy14AqYoqgKCCrvdNi2v073VxvRCQVnixrWX0?=
 =?us-ascii?Q?vBK2rJiwWXsnuKt2tliba30x+aDT2CEAxT/Sas++e2Mvaau1rqQGLhUrF8HD?=
 =?us-ascii?Q?HbDFuf9MYXxqlWGfu3/YVtLs3vaBWJ6wKGJxvQtuBdwaEMQJSApx1mUlgKZa?=
 =?us-ascii?Q?gfSTicA019M/1IvuhtoRtKm/vdPPttL0rWfENUFbNc4zgHt4g8PsEmsIQ4ZM?=
 =?us-ascii?Q?aUjqmpyJMXj2PMvMWxQ5xPjRGwudK7op0CiJ/JaWrLlrEZ9SJmuew/JrB2KP?=
 =?us-ascii?Q?EiLrS7AIVfIyJ3NKRTUrwhz7N9bCc4uynwTGNr2OF7DxgH/JUrxs0c1wQw8q?=
 =?us-ascii?Q?Ov7VnRDGyBcUNlYJ38UtJxSgMYagTfyxtPeVtVJRDwrDVg/dEC3EQ+jlYzrV?=
 =?us-ascii?Q?pOjDzcNoxf4fOIWQrEplOHcdZ6e+PB4DmiZWWyRF8QTiSiCDxcFBERS8RJsX?=
 =?us-ascii?Q?6VnrWQaE0CtZjTQLPivA5NXF9JjXYs33zaDK/Ph9ONnD09FI9kfb6Cfe4Id5?=
 =?us-ascii?Q?5IdgndxSZGPC19DZ2J84lR3hYhuKvGzdXegftpxq85SCCPrbwk4JQ/gxgF6o?=
 =?us-ascii?Q?l+p021nLOrC86uOAHEVcV+oW3K5k5kQob85xtaLYYu+FzJ+h6xX8uMq6b+7e?=
 =?us-ascii?Q?Pa+Q+UV44aQv7V80DIlAMPabUbTiiKS4sk+TIOag8kfW22wkFAtNc4HhtvuR?=
 =?us-ascii?Q?LcXSYeenooo3EtBA19HKWu3ayXJmd21MQt8bPt/37NEa+KiQue6r28PUtGNH?=
 =?us-ascii?Q?4RT8FJ/hmLIvcEY/Q426igJz7oIFXFYHf/JfRC704F1M4HRzdCNS83Bpblr7?=
 =?us-ascii?Q?J17XSXM2vj4efl7CJf+28VfeXPE6X2WDOuvKlm3sjh025Ftrkvu9CZKTN1oz?=
 =?us-ascii?Q?g7q/wpjMIyQuHH/PGoBgcA1adFHQPxOARBxUrl7h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771c68b4-5a72-40b3-825a-08da63e3edd0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:53:02.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MLWF7DftGiOeQDwiRpV5QEhonPoqDOZcy25qtLx7jem8snWaP2ps47JXvH1OpG0VDzjdcfcYtEKn8L8x5pFUryzs0T/ECL8TG8SGDimxjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1531
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=592 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120034
X-Proofpoint-GUID: 8Bo0O3CgaRSJ7CjvVSNNRSJcsPb0A0zD
X-Proofpoint-ORIG-GUID: 8Bo0O3CgaRSJ7CjvVSNNRSJcsPb0A0zD
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Keith Busch,

The patch 7b1ccdf617ca: "block: fix leaking page ref on truncated
direct io" from Jul 5, 2022, leads to the following Smatch static
checker warning:

	block/bio.c:1254 __bio_iov_iter_get_pages()
	error: uninitialized symbol 'i'.

block/bio.c
    1195 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
    1196 {
    1197         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
    1198         unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
    1199         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
    1200         struct page **pages = (struct page **)bv;
    1201         ssize_t size, left;
    1202         unsigned len, i;
    1203         size_t offset, trim;
    1204         int ret = 0;
    1205 
    1206         /*
    1207          * Move page array up in the allocated memory for the bio vecs as far as
    1208          * possible so that we can start filling biovecs from the beginning
    1209          * without overwriting the temporary page array.
    1210          */
    1211         BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
    1212         pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
    1213 
    1214         /*
    1215          * Each segment in the iov is required to be a block size multiple.
    1216          * However, we may not be able to get the entire segment if it spans
    1217          * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
    1218          * result to ensure the bio's total size is correct. The remainder of
    1219          * the iov data will be picked up in the next bio iteration.
    1220          */
    1221         size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
    1222                                   nr_pages, &offset);
    1223         if (unlikely(size <= 0))
    1224                 return size ? size : -EFAULT;
    1225 
    1226         nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
    1227 
    1228         trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
    1229         iov_iter_revert(iter, trim);
    1230 
    1231         size -= trim;
    1232         if (unlikely(!size)) {
    1233                 ret = -EFAULT;
    1234                 goto out;

"i" is uninitialized on this path.  (You probably have already fixed
this and recieved a million other static checker notifications).

    1235         }
    1236 
    1237         for (left = size, i = 0; left > 0; left -= len, i++) {
    1238                 struct page *page = pages[i];
    1239 
    1240                 len = min_t(size_t, PAGE_SIZE - offset, left);
    1241                 if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
    1242                         ret = bio_iov_add_zone_append_page(bio, page, len,
    1243                                         offset);
    1244                         if (ret)
    1245                                 break;
    1246                 } else
    1247                         bio_iov_add_page(bio, page, len, offset);
    1248 
    1249                 offset = 0;
    1250         }
    1251 
    1252         iov_iter_revert(iter, left);
    1253 out:
--> 1254         while (i < nr_pages)
    1255                 put_page(pages[i++]);
    1256 
    1257         return ret;
    1258 }

regards,
dan carpenter

Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D280C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59410208E4
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPqsz4ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBRIBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:01:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfBRIBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 03:01:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1I7rsrV125587;
        Mon, 18 Feb 2019 08:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yb0yjohAQQBkLYrkAUTNn2Fm+uOKEZbrBxJ9JzRMoG4=;
 b=LPqsz4wwkw/XQuOsG0YfI8m/gmnPTxLPn9bHlQtNw5QTStS6eqvqqM9brS1AFWS1EF8B
 6aMujrspMqq02zuCSimZbHaYitsayjtqYdEQdpUkt0ZjTH2jIr5ototZfXtGoUUcr29Q
 L5CFfeDUQt3D5hsLr4Amq2Wm7bBCVhKG5HJBMTH0qXiMKG6pEg8U1t+bRNyJeldGi5m0
 yUe9yuAMMcXYVV9VcMd3fWEhAtSHgM/rIRo2qq2e2vo+sIwPb+ykhZiZ40V40XdMeuWD
 4yRikel5HdmNEWOs2k7JpwnRGhm9mxXbOWERmnn7DcrDNeyheHuLe9gphGEp5CTo9UKm Gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5r4m9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:01:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1I811ds012511
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:01:01 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1I810oq021616;
        Mon, 18 Feb 2019 08:01:00 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 00:01:00 -0800
Subject: Re: [Xen-devel] [PATCH v6 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>, konrad.wilk@oracle.com
Cc:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Paul.Durrant@citrix.com
References: <1547484104-20625-1-git-send-email-dongli.zhang@oracle.com>
 <1547484104-20625-2-git-send-email-dongli.zhang@oracle.com>
 <20190115082036.y7svi3xz3dkqd4w4@mac>
 <20190117152919.GA26079@localhost.localdomain>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <49564120-813d-2b80-94be-bde8123809a9@oracle.com>
Date:   Mon, 18 Feb 2019 16:04:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117152919.GA26079@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180063
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Konrad,

On 1/17/19 11:29 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 15, 2019 at 09:20:36AM +0100, Roger Pau Monné wrote:
>> On Tue, Jan 15, 2019 at 12:41:44AM +0800, Dongli Zhang wrote:
>>> The xenstore 'ring-page-order' is used globally for each blkback queue and
>>> therefore should be read from xenstore only once. However, it is obtained
>>> in read_per_ring_refs() which might be called multiple times during the
>>> initialization of each blkback queue.
>>>
>>> If the blkfront is malicious and the 'ring-page-order' is set in different
>>> value by blkfront every time before blkback reads it, this may end up at
>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
>>> xen_blkif_disconnect() when frontend is destroyed.
>>>
>>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
>>> once.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>
>> LGTM:
>>
>> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Applied.
> 
> Will push out to Jens in a couple of days. Thank you!
>>
>> Thanks!

I only see the PATCH 1/2 (xen/blkback: add stack variable 'blkif' in
connect_ring()) on the top of below branch for Jens, would you please apply this
one (PATCH 2/2) as well?

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git/log/?h=linux-next

1/2 is only a prerequisite for 2/2.

Thank you very much!

Dongli Zhang

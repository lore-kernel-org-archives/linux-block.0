Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE294C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 04:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7831A2084C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 04:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfWe761W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfDCEV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:21:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCEV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 00:21:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x334Jl5o139343;
        Wed, 3 Apr 2019 04:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=C7/C8uTEo4ZaBw6Hn6VFIbpNsmVwCI6sGV/YXbFIpRI=;
 b=EfWe761W9cBTS1tUhlODlmo4Dyr+MoJ2KF5U96OtJdoF2vuos+PWDnTaQ8daKoIKghGJ
 wg7A2Lk8/nkTRSSFvsSAXPelSiieiVn12ul62Irc6GAOJzbQEhaHQ3x8VOsLhIdtmgfG
 fhDSXD2UZHUd9O4Ieyi++4O/oMgIanhAle0Qxp/JlNOFQTE1JbzApoT3tWCSDVwf0pP+
 RVLPeVYPKsP89OWG435u2PmIJ8GS4fXg+u+4mmGKaW/uuLoKSZKCtfXlv+zhrt4BdqH8
 FQGtiPTW9NhEHyyr7nS2SrMS8/E429OX7MdsdZdLftfZorq3mtRXumq2YdqczXcX+RNL Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2rj0dnnpkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 04:21:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x334JpES115767;
        Wed, 3 Apr 2019 04:21:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rm8f4vere-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 04:21:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x334LEQn027050;
        Wed, 3 Apr 2019 04:21:15 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 21:21:14 -0700
Subject: Re: [PATCH] SCSI: don't hold device refcount in IO path
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190402114800.2281-1-ming.lei@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <79c85f5b-863c-539c-b702-009ad3fac3cc@oracle.com>
Date:   Wed, 3 Apr 2019 12:25:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190402114800.2281-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030026
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=832 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/2/19 7:48 PM, Ming Lei wrote:
> scsi_device's refcount is always grabed in IO path.

'grabbed'

> 
> Turns out it isn't necessary, becasue blk_queue_cleanup() will

'because blk_cleanup_queue()'

> drain any in-flight IOs, then cancel timeout/requeue work, and
> SCSI's requeue_work is canceled too in __scsi_remove_device().

Dongli Zhang

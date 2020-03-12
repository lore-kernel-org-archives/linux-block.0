Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A9C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 20:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C1B206CD
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 20:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vgkRU/t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCLUm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:42:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 16:42:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CKfANY136710;
        Thu, 12 Mar 2020 20:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=23rZ+8zZxe1JeZH6FM88sMD941d28e/gBOsTaM2azZg=;
 b=vgkRU/t3wtyw/PhgPQicGtp6GxUFOs3bMZieXMUCPN6cfvV7ptBuXc35ICd0mRmqw9j6
 MSvpiMQdeA6k1qFK/QPqzhLaEv/SBDRv8HDO1mTBNhFngrnmgxh42BkKI3WSM+8+M+aC
 q6RTmYnv2/NrA/sRD9lhIvEsGFhYV/jT6Aq3VzxrOnbtwDh3MJasMhzxV3n6cG2gqzFX
 S5vtiY+ShVSN1kXReLy7ksmesYYzE2B+suwAAdd8BZ1d8sQv4WzdYLB+UM5WffTM4ufY
 aO3LvcbhnOmJtUhYgVsZYFEBpOXXYQ4iEEOj7hXykHZD1fjJzm0qnEXNqWWK43tH7CRq yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yqtaermh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 20:42:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CKe03I156185;
        Thu, 12 Mar 2020 20:42:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yqtabwmty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 20:42:56 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CKgs5g020995;
        Thu, 12 Mar 2020 20:42:55 GMT
Received: from dhcp-10-211-46-13.usdhcp.oraclecorp.com (/10.211.46.13)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 13:42:54 -0700
Subject: Re: [PATCH 1/1] null_blk: describe the usage of fault injection param
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200304191644.25220-1-dongli.zhang@oracle.com>
 <052ba0ac-e0ec-9607-e5c8-acbee8ab6162@kernel.dk>
From:   dongli.zhang@oracle.com
Organization: Oracle Corporation
Message-ID: <38dfc76c-efb8-5447-c8e8-4c0079dbb55f@oracle.com>
Date:   Thu, 12 Mar 2020 13:42:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <052ba0ac-e0ec-9607-e5c8-acbee8ab6162@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=3
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=3
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/12/20 6:57 AM, Jens Axboe wrote:
> On 3/4/20 12:16 PM, Dongli Zhang wrote:
>> As null_blk is a very good start point to test block layer, this patch adds
>> description and comments to 'timeout' and 'requeue' to explain how to use
>> fault injection with null_blk.
>>
>> The nvme has similar with nvme_core.fail_request in the form of comment.
> 
> This doesn't apply to for-5.7/drivers, care to resend?
> 

I would resend based on for-5.7/drivers.

Thank you very much!

Dongli Zhang

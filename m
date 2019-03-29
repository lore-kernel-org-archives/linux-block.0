Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D655CC10F05
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A32183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CyQGbY4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfC2OmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:42:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51616 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2OmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:42:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEYKXp024448;
        Fri, 29 Mar 2019 14:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=g4x5JEl3MDDss/pGR5g5kuLrCuM4XZMFh325aQf57C4=;
 b=CyQGbY4J9CtNKRxcg6LM9DfVKWR7YfIAyqqvZqJvYGENsKBlUAtYHTqN0qD8T261lj45
 qyzObRMpl9Lxr31fyt3GaT3jZ5xRSnEPTxKnKi5WIybR7MjHLmbBQ4gaGcEFL2xKFoiH
 f4G93efm8FIDql6+BnArVi1RUhgi8w0RBQ9om73Bo9PKvb20lIcf68n2qRY9fvkm5FS9
 APYtylIjZ7H7uAvYKgsZLRZ582ONz4zuZhvCsrCG7qfO+j3F5KPVgHnt6Y1A5Hd3XtUC
 W7rq9JHZFU00f5hAx5GYopWNteBXVhaZ6JzGqKZFL/5tPRozbSTANyUReQRkBjEZ9aBQ 3A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g1cv19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:42:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEfnXt026765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:41:50 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEfnCX030013;
        Fri, 29 Mar 2019 14:41:49 GMT
Received: from [192.168.1.12] (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:41:49 -0700
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <c3c942f4-8006-37fe-5996-458526c51254@oracle.com>
Date:   Fri, 29 Mar 2019 22:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <yq1ftr5rbq1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 10:34 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> I told you this for the initial posting, and the objection still
>> stands.  Adding 40 bytes to struct bio is a no-go.
>>
>> So that's a big NAK on that series.
> 
> I think you missed Bob's comment that this will go in the existing
> bio_integrity field. I believe the main purpose of the series is to
> solicit feedback on the callback approach.
> 

Yes, indeed!


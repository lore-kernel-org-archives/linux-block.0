Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2926C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811022184C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o5vomxwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfC2OlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:41:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50444 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfC2OlM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:41:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEYAM8024330;
        Fri, 29 Mar 2019 14:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BA1AYr2ucxnuv3ubR2s3P90REEFgNoCOQ/E7/18xvrM=;
 b=o5vomxwDO0UCZXST52/SM7nKWzDoTnRZdogv3hmtMfxr2eXoBEMZM+x9mfIdqLCrMgFr
 9/GZij5HZFieR2xsuFgxeIPYFRmw0yQZt+GmlHc77WI6xgvHWOj6kPMZZjjp1KzAYbs4
 B80twgouddlnpm05sVzRUMZvbg08/FW7QgmNRw3cI5EbGcttFODSm7iarU3jDOpzRBou
 D5musFetXit1SrzG6KAXDhy1i8m0AdXlGylgnOjQvHsOvw3bl9MUxJt1aNF6LFVfqPzB
 QW9xvxGt6apYFePXs4vfCLMGPa1rs4PvKuoTxjo616FlsQFGEuC3tfblyN5K6ZUdrd+e fA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g1cuts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:40:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEewYZ013929
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:40:58 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TEev8F030271;
        Fri, 29 Mar 2019 14:40:57 GMT
Received: from [192.168.1.12] (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:40:57 -0700
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <73ecbb57-fd99-5df3-8859-e218b830363b@oracle.com>
Date:   Fri, 29 Mar 2019 22:40:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
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

On 3/29/19 10:28 PM, Jens Axboe wrote:
> On 3/29/19 8:23 AM, Bob Liu wrote:
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index d66bf5f32610..e9f25f162138 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -18,6 +18,7 @@ struct block_device;
>>  struct io_context;
>>  struct cgroup_subsys_state;
>>  typedef void (bio_end_io_t) (struct bio *);
>> +typedef int (bio_verifier_t) (struct bio *);
>>  
>>  /*
>>   * Block error status values.  See block/blk-core:blk_errors for the details.
>> @@ -187,6 +188,8 @@ struct bio {
>>  		struct bio_integrity_payload *bi_integrity; /* data integrity */
>>  #endif
>>  	};
>> +	bio_verifier_t		*bi_verifier;	/* verify callback when endio */
>> +	struct work_struct      bi_work;	/* I/O completion */
>>  
>>  	unsigned short		bi_vcnt;	/* how many bio_vec's */
> 
> I told you this for the initial posting, and the objection still stands.
> Adding 40 bytes to struct bio is a no-go.
> 

Yes, I know that.
Already list in Todo:
- union with "struct bio_integrity_payload *bi_integrity" to save bio space.

This is only a rfc patch, because not sure any other objection of this passdown-verify solution..
Will consider more about the bio space if there is agreement of the passdown-verify way.

Thanks,
Bob

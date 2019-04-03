Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF78C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E42084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDCRNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:13:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfDCRNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 13:13:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33H5ekb098064
        for <linux-block@vger.kernel.org>; Wed, 3 Apr 2019 13:13:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmyht5207-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 13:13:15 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <anoo@linux.ibm.com>;
        Wed, 3 Apr 2019 18:13:14 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 18:13:10 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33HD98r20709578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 17:13:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5368D112063;
        Wed,  3 Apr 2019 17:13:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4D9C112064;
        Wed,  3 Apr 2019 17:13:08 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 17:13:08 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Apr 2019 12:13:53 -0500
From:   Adriana Kobylak <anoo@linux.ibm.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     medadyoung@gmail.com, openbmc@lists.ozlabs.org,
        nbd@other.debian.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd:clear NBD_BOUND flag when NBD connection is closed
In-Reply-To: <a1da3fff285fe13d04522f1a6e72bdc1@linux.vnet.ibm.com>
References: <1544509023-18923-1-git-send-email-medadyoung@gmail.com>
 <a1da3fff285fe13d04522f1a6e72bdc1@linux.vnet.ibm.com>
X-Sender: anoo@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 19040317-2213-0000-0000-0000036FFDF3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183815; UDB=6.00619799; IPR=6.00964567;
 MB=3.00026280; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 17:13:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040317-2214-0000-0000-00005DE3E233
Message-Id: <7e192d24976532141c8c985329f5ca1c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adding Josef (updated email address in the maintainers file).

On 2018-12-13 08:21, Adriana Kobylak wrote:
> On 2018-12-11 00:17, medadyoung@gmail.com wrote:
>> From: Medad <medadyoung@gmail.com>
>> 
>>     If we do NOT clear NBD_BOUND flag when NBD connection is closed,
>>     then the original NBD device could not be used again.
>> 
>> Signed-off-by: Medad <medadyoung@gmail.com>
> 
> Tested on Witherspoon (OpenPOWER P9 with AST2500) and verified with
> this patch that the NBD device could be disconnected/reconnected.
> 
> Tested by: Adriana Kobylak <anoo@linux.ibm.com>
> 
>> ---
>>  drivers/block/nbd.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 64278f4..5c88490 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -277,10 +277,14 @@ static void sock_shutdown(struct nbd_device 
>> *nbd)
>>  	struct nbd_config *config = nbd->config;
>>  	int i;
>> 
>> -	if (config->num_connections == 0)
>> +	if (config->num_connections == 0) {
>> +		clear_bit(NBD_BOUND, &config->runtime_flags);
>>  		return;
>> -	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags))
>> +	}
>> +	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags)) {
>> +		clear_bit(NBD_BOUND, &config->runtime_flags);
>>  		return;
>> +	}
>> 
>>  	for (i = 0; i < config->num_connections; i++) {
>>  		struct nbd_sock *nsock = config->socks[i];
>> @@ -944,7 +948,7 @@ static int nbd_reconnect_socket(struct nbd_device
>> *nbd, unsigned long arg)
>>  		sockfd_put(old);
>> 
>>  		clear_bit(NBD_DISCONNECTED, &config->runtime_flags);
>> -
>> +		clear_bit(NBD_BOUND, &config->runtime_flags);
>>  		/* We take the tx_mutex in an error path in the recv_work, so we
>>  		 * need to queue_work outside of the tx_mutex.
>>  		 */
>> @@ -1020,6 +1024,7 @@ static int nbd_disconnect(struct nbd_device 
>> *nbd)
>>  	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
>>  	set_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
>>  	send_disconnects(nbd);
>> +	clear_bit(NBD_BOUND, &config->runtime_flags);
>>  	return 0;
>>  }


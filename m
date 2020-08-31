Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C0C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA702078B
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6ExOHZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHaXCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:02:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50302 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHaXCT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 19:02:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VN0YgN089588;
        Mon, 31 Aug 2020 23:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=jbL6kkZsM8ZtBA4GGpH1Pn6ZCEsatvJTdYT+6rZ3jpg=;
 b=G6ExOHZ5R517Y4VHtz4YVZoGUCFJpq6LK6REvdXblvfHofyjrqxogC0ncjMKaprjJUyp
 iSuua1jmc/EFa9tZ6X0FjmF0Tytk8u2xTOXe9rXSvH9mKkU1Yapy0pLV38eCyX68dxTn
 qLAkTfolr9dMf8y1fHrWOtK6qCIOYwccVCTwc1nYM+PVdm4Mali54/eolD2LsDWqj9wu
 VqFmQkworE/ULKituFgdjW4M5n5QdcJxfdspzBXGHY+taMV9TC924AUU/wHyh7BXBq3x
 5G1yfJFQg8GwWFEtQ6rm29RFXNJiQy9Yg8dWVOZJJ/TfgTxd5ZLCY8PwnNFUnH+2HXeJ Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eym0y49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 23:02:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VMtcBs122349;
        Mon, 31 Aug 2020 23:02:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3380xvfgxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 23:02:16 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07VN2FFt007074;
        Mon, 31 Aug 2020 23:02:15 GMT
Received: from dhcp-10-159-154-8.vpn.oracle.com (/10.159.154.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 16:02:15 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <6d864384-2b6c-0a1f-8f85-9ec5acb5b484@kernel.dk>
Date:   Mon, 31 Aug 2020 16:02:14 -0700
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <96A5A178-8E22-4763-8C0F-450E0B201197@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
 <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
 <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
 <d5c2818f-ed6e-e8ff-709d-ecc4858ff4de@kernel.dk>
 <67BDE4B3-830C-476F-939F-5AB2634E0F7D@ORACLE.COM>
 <6d864384-2b6c-0a1f-8f85-9ec5acb5b484@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens for the update.
I will send the patches on top of 5.10 branch.

Thanks,
Ritika

> On Aug 31, 2020, at 8:38 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 8/28/20 11:10 AM, Ritika Srivastava wrote:
>> Thanks Jens for the update.
>> I will look out for 5.10 branch and send the updated patches.
> 
> I pushed it out this morning.
> 
> -- 
> Jens Axboe
> 


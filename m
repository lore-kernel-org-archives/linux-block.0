Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8CC5CFFE
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946A92084E
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946A92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvtech.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeLJUrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:47:00 -0500
Received: from pmta31.teksavvy.com ([76.10.157.38]:18412 "EHLO
        pmta31.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLJUq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 15:46:59 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 15:46:59 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GABgBYzg5c/wXKF4dkHgEGBwaBZYIEg?=
 =?us-ascii?q?VYSJ4N6iHiNPjUBmRYNhGwCgysjOBIBAwEBAQEBAQICAmkohT0BAQEBAgEjFR4?=
 =?us-ascii?q?jBQsLEQMBAgECAiYCAjkWCAYThRsIBaYfgS+KKoELiy2BQD+EI4gFglcCkDqQO?=
 =?us-ascii?q?wmRRBUOA4ljh1eZMASBWSKBVjMaCDCDJ5B5IQEyjSMBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GABgBYzg5c/wXKF4dkHgEGBwaBZYIEgVYSJ4N6iHiNPjU?=
 =?us-ascii?q?BmRYNhGwCgysjOBIBAwEBAQEBAQICAmkohT0BAQEBAgEjFR4jBQsLEQMBAgECA?=
 =?us-ascii?q?iYCAjkWCAYThRsIBaYfgS+KKoELiy2BQD+EI4gFglcCkDqQOwmRRBUOA4ljh1e?=
 =?us-ascii?q?ZMASBWSKBVjMaCDCDJ5B5IQEyjSMBAQ?=
X-IronPort-AV: E=Sophos;i="5.56,339,1539662400"; 
   d="scan'208";a="56449720"
Received: from 135-23-202-5.cpe.pppoe.ca (HELO AlphaBase.mvtech.ca) ([135.23.202.5])
  by smtp.teksavvy.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 15:38:25 -0500
Received: from mvtech.ca (localhost [127.0.0.1])
        by AlphaBase.mvtech.ca (8.15.2/8.15.2) with ESMTP id wBAKcNQ5028275;
        Mon, 10 Dec 2018 15:38:23 -0500
Received: from RSM-VLAN35.ubishops.ca (RSM-VLAN35.ubishops.ca
 [207.162.104.1]) by webmail.mvtech.ca (Horde Framework) with HTTPS; Mon, 10
 Dec 2018 15:38:23 -0500
Date:   Mon, 10 Dec 2018 15:38:23 -0500
Message-ID: <20181210153823.Horde.GRBio9K4vBg5SwwJsjOMqop@webmail.mvtech.ca>
From:   Todd Aiken <taiken@mvtech.ca>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Restore tape support
References: <20181210030814.13235-1-bvanassche@acm.org>
 <20181210153230.GB25206@localhost.localdomain>
 <1544472412.18488.5.camel@redhat.com>
 <20181210202647.GA8101@localhost.localdomain>
In-Reply-To: <20181210202647.GA8101@localhost.localdomain>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

----- Message from Keith Busch <keith.busch@intel.com> ---------
    Date: Mon, 10 Dec 2018 13:26:47 -0700
    From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] block: Restore tape support
      To: Laurence Oberman <loberman@redhat.com>
      Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe  
<axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph Hellwig  
<hch@lst.de>, Todd Aiken <taiken@mvtech.ca>, stable@vger.kernel.org


> On Mon, Dec 10, 2018 at 03:06:52PM -0500, Laurence Oberman wrote:
>> Tested and works fine.
>> Thanks All
>>
>> Tested-by: Laurence Oberman <loberman@redhat.com>
>
> Cool, thank you for confirming.

I can also confirm that this fix works fine on my system.


----- End message from Keith Busch <keith.busch@intel.com> -----




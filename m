Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54457C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273A520663
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HbQtAGWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCLOA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:00:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34409 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 10:00:26 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so5787716iof.1
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BB7+HmZ8n9xtOnZvmip1O8s6xRT1TqxCLXiFq9TEIAw=;
        b=HbQtAGWBBa4WFv90X5xRKxAct4BfLuIDN0UBXvcvzQBsrgp/fhsSIf49Ddwv2Qdzgr
         a0HQqNzmwbV6LWk7avu1xo5OlJIM5KFeoPlh8HTZvgipMG7EbKUAPI67VjBEfbOYec0/
         +1jxLmKpx0J0k5VX3Z3SuJ1VBG3Fw+Fd4A0dmcMEWkmEG5fhq77DO0VJm12LXIH8nKDL
         +KRoHburJXpgtlgCoZhCEBS/xTCyxZqXJXbllAAktGG3HbyMw2XbVoUsx1yEbdz/4uj9
         ss3ZuV2FxwcuuWN8ogbzgOnhJHw0sWfWp2KDC2rFkTq+UTVkRtQTBxjBCs4fQ2Y3F/sb
         rzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BB7+HmZ8n9xtOnZvmip1O8s6xRT1TqxCLXiFq9TEIAw=;
        b=V1EZKdjuETv34ZeROO+WAchbfyjiCBAXN5LIkBdXXKRC535wUGCXuFIpUPe2D0UeH2
         WpPOQYZ9m9gz1fgAg8lXlEkL74RWTmWhZekZ0rbo4Ksji7IOIB8UwKULxLVldfVtjUvt
         qzZuDwzovv8j10jZpPC7c6ka21gjO69DDE25XqplB8/DqAf/m0iSHmku6gQGKJblk/eo
         zQOmKKagOyQRBGcgeW8QRyFIR9ghfcP4nO06ia67RYcd0Byl9A0DWmSL4ugEBnDdfN0g
         /XsaeBd9ad9RWYc6nhma6fF9xCAt/Y9rpR3aLzTDIJ5jicvCXOLQuUpkNDb7xv2X2pmv
         4KKQ==
X-Gm-Message-State: ANhLgQ0Zkcj/2EFNnzTN4LvGDO9jpMiGTxcUBeJTyqlPtgsiizuno6Xm
        62kudJFSbBtph+x3naFTcZCgeQ==
X-Google-Smtp-Source: ADFU+vsA+Mmlc+tJTk8PDsfWdHVWeWgKrzr3WbtfHBMG/50Dtmx6D4T+huc9NZA+UCf9n5hZ8fye6Q==
X-Received: by 2002:a5d:9708:: with SMTP id h8mr7766968iol.141.1584021625421;
        Thu, 12 Mar 2020 07:00:25 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n26sm15074921ioo.9.2020.03.12.07.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:00:24 -0700 (PDT)
Subject: Re: [PATCH v2] block: sed-opal: Change the check condition for
 regular session validity
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        =?UTF-8?Q?Andrzej_Jakowski=c2=bb?= <andrzej.jakowski@intel.com>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
References: <20200303191700.66667-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3817f650-18be-653b-9bc0-c90f279c2813@kernel.dk>
Date:   Thu, 12 Mar 2020 08:00:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303191700.66667-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/20 12:17 PM, Revanth Rajashekar wrote:
> This patch changes the check condition for the validity/authentication
> of the session.
> 
> 1. The Host Session Number(HSN) in the response should match the HSN for
>    the session.
> 2. The TPER Session Number(TSN) can never be less than 4096 for a regular
>    session.
> 
> Reference:
> Section 3.2.2.1   of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf
> Section 3.3.7.1.1 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf

Applied, thanks.

-- 
Jens Axboe


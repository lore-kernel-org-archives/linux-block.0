Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9AAC61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A74B2084F
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfASRAQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:00:16 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:37437 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfASRAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 12:00:16 -0500
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gktyU-0004K2-Ra; Sat, 19 Jan 2019 10:00:02 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gktyU-0004z9-3t; Sat, 19 Jan 2019 10:00:02 -0700
Received: from hacktheplanet (unknown [73.58.156.101])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6E3C7212F61;
        Sat, 19 Jan 2019 17:00:00 +0000 (UTC)
Date:   Sat, 19 Jan 2019 11:59:53 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, jonathan.derrick@intel.com
Message-ID: <20190119165953.GA12171@hacktheplanet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gktyU-0004z9-3t;;;mid=<20190119165953.GA12171@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 09/16] block: sed-opal: split generation of bytestring
 header and content
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 09:31:49PM +0000, David Kozub wrote:
> -
> -	memcpy(&cmd->cmd[cmd->pos], bytestring, len);
> +	start = &cmd->cmd[cmd->pos];
>  	cmd->pos += len;

This is somewhat pendatic, but it helps me review patches if we keep things together.
Since we're no longer doing the memcpy in this function, can we please move the cmd->pos += len
to the location where we actually do the memcpy.

I'm willing to be told to get over it if other reviewers don't like that approach, but if no one cares
please move it.


> +	return start;
> +}
>  
> +static void add_token_bytestring(int *err, struct opal_dev *cmd,
> +				 const u8 *bytestring, size_t len)
> +{
> +	u8 *start;
> +
> +	start = add_bytestring_header(err, cmd, len);
> +	if (!start)
> +		return;
> +	memcpy(start, bytestring, len);

Do the above here instead.

> 2.20.1
> 
> 

Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F491C282C3
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70820856
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Js1VAzXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfAWAA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:00:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34865 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAWAA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 19:00:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so201775pfi.2
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x1DkyEkp7+WpcgVJDLq3Dzt8lmF0TU4YSY5E/UEadds=;
        b=Js1VAzXj0LpnkP8v1KMomgePzsUjk/GU/buB8dsN/i/oCAlpR2p3C+mPlVSNbqycdY
         nknVmn1cVNNwqLLvpjgGdkOuMXoYAp80Lc6B7hRz5HLh6QO1cddc5t7G6QMii5pnhxoR
         laso06rknJALru7JZh25bsOocVvpS0yOE1Dqq/sTpMp4x1lHA5SlmQrt3JrhVTzgYViu
         C0mswsqruBU8wCGDMii4Mb9uuLUk/nLhWSrFtMojnCz7XwtETV95G7a0GS2m8XUwU22r
         PcohG1NnwJ9BNakcCMz4B+2lD4EJYOcfPYC6hJ/cfzFZJFD5Wz13XitkJ3efgAEFatHj
         Wr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x1DkyEkp7+WpcgVJDLq3Dzt8lmF0TU4YSY5E/UEadds=;
        b=F6lHCuYLIyCxwi2oOPTzuw5yoHmvSruzqfjGEwtzB4XoOfqZ2ooVTd20JG811O1cRZ
         rRT+5SdxN9bNvbyl7xUqeVGechN35P15NLCOHnn+RXnZ1Z7hF/ZsoiloarVzxUm8rojK
         k5K8icEf4xtYh713Q/MAxJ9TK+ClbZutMNTXmDr+keohEVJ9CdbbjjLTtGDWvNGHe4b+
         a9OwknR4InL+iyUCZ1qAIk75zsj45zT7Sq7RgxIcQ6QSws4vTpOcmQtNTACCW50eFNoK
         vH2ERTfo1MIsZ4MavxKcDeTQsWFjVaeeUH8/hUORe7tQgeDDJqO+EfXML0MGYfA+tYLe
         QKDA==
X-Gm-Message-State: AJcUukfg7MTHA3F+7doa3h29zPDzDgyERQJ1fqfc2foyoUvlGNDhgvvi
        sDRYMfLkwVmwTORT07mjPMZrM4n9gns=
X-Google-Smtp-Source: ALg8bN4W3zr4V3YJjctSeZNs6EKJwzRnkrKSgmZoyPzv+ED2nOv1ifnbPxEgUluUo/cGaE+D/WvcAQ==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr4407pgf.87.1548201658290;
        Tue, 22 Jan 2019 16:00:58 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:930f])
        by smtp.gmail.com with ESMTPSA id e86sm25413572pfb.6.2019.01.22.16.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:00:57 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:00:56 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: Add test for changing capacity when filesystem
 is mounted
Message-ID: <20190123000056.GD5884@vader>
References: <20190121120203.13644-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121120203.13644-1-jack@suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 21, 2019 at 01:02:03PM +0100, Jan Kara wrote:
> Add test for changing capacity of a loop device when a filesystem with
> non-default block size is mounted on it. This is a regression test for
> "blockdev: Fix livelocks on loop device".
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, Jan, applied.

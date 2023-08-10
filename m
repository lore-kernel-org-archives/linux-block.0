Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A87C41513
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 08:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHJI0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjHJI01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 04:26:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DEEDC
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 01:26:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso5177965e9.3
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691655984; x=1692260784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MR+5PFugPovCt/ZI4txJmfCVwmNkCdr2Q2Ayqtgi6o=;
        b=WdVTRiGcf7KWGdovrZhaYzLlwUVf9l8MODnlO7thvaEU+sC0Cza6ueuUU76mU8Yg74
         0Rfo3A/G1LS/Qpxbw/kebtdiDnffZ1PK1Mx5ni/vhp3Ox7JYgNyro81tJz49qyjI1pOK
         nXuUDwV0PAqZUQNv4nlVTSbu3x2EUPBXuiF4vH/71+DABd10ENZekJgw0hYnm8/PwMEF
         i5p1L6KLu2lJzaH3F6JrSSNIBk9oWL7DxAe5ybu6qlCzdOL0mloNb9GsVjRy3Bnos7vy
         72nD56tdS3xUOhovArpb5gjat/Vw/j1shREx+OLuLKoXGr320YfTYLqIq7zmUj50GZX1
         N8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655984; x=1692260784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MR+5PFugPovCt/ZI4txJmfCVwmNkCdr2Q2Ayqtgi6o=;
        b=d7qulJCtGL+odiLv2QlujvV1SjUCyytL2OTe2wPkpL0hM95c8lZotn74g5VxQFKDxN
         6APD0WCaMm/I3kmiCRObAfkX+7jFs7F+qlKB3fdnHqGQsHowqJ/D2avdeMCBkHFZpo5l
         NIy1sjqaJXu16Z2tigVjvqA3A5wtLi6N7Hxumldy2+L6xleZ4TqMabN/EnMm/qB8bnK4
         deGk5vXwinIoBZtKiirLg++f9x11VyuBOsqPLCUWq0QHct3QEB8ECgt27EFH0nrMWBjD
         mazpPmLtTZgLdiDEfYtSlss5QmgWtTYfmLUs2qchiO9bfjz5uHQpmV+TBTifKt0NEcoT
         CBLQ==
X-Gm-Message-State: AOJu0Yyd2+JPlT0eCcmITloNAFljdspxkGadGDmEhniQUOPkXT+vH9Xr
        hBH0+vzIPAh7Jn70zJHAABLEHg==
X-Google-Smtp-Source: AGHT+IED5EvUAbIPy9tMLOguRqy1DoclqnEEVwX479WbGpTt1LpbY1tJy4NuoGcxJzNG8xckTlf9Gw==
X-Received: by 2002:a7b:cd0d:0:b0:3fa:98c3:7dbd with SMTP id f13-20020a7bcd0d000000b003fa98c37dbdmr1240929wmj.41.1691655984457;
        Thu, 10 Aug 2023 01:26:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4321899wmc.21.2023.08.10.01.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:26:23 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:26:22 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, johannes@sipsolutions.net,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, axboe@kernel.dk, pshelar@ovn.org,
        jmaloy@redhat.com, ying.xue@windriver.com,
        jacob.e.keller@intel.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, dev@openvswitch.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
Message-ID: <ZNSfLomTSZy/4b8W@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Wed, Aug 09, 2023 at 08:26:41PM CEST, kuba@kernel.org wrote:
>Only three families use info->userhdr and fixed headers
>are discouraged for new families. So remove the pointer
>from struct genl_info to save some space. Compute
>the header pointer at runtime. Saved space will be used
>for a family pointer in later patches.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

I'm fine with the existing message, but what Johannes suggests is also
ok.

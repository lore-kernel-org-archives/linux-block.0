Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 14:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiCVOcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiCVOck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 10:32:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DF6A033
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 07:31:09 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so20377345iod.6
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=t05Th32JwFDrspvfCaVps5qrLbDP0ziOmcXOCj+YI1c=;
        b=e/h6mYvfKkqxTpmfWQ4Yuch+bsPz50kWhMGT4l/YW+ZUMSiC+HAxDHyDfiQRoIWlLg
         XbsiamVpeAR6paILZHVtuwl4io+JDT/UTXpJx/ifbxA5FgCuChqbwLGjhB+VwNaODHwh
         C68qtxVrNwkTrUt0pLGYK9bCod8NIgLD/Hr3HZq7UVe4ZVf0DxY3aGTw4oF+9ltL2/eJ
         kveQWUYXUt7108qSTWcXa74azYygc/kfmFDJXzVPl3HJkp4Pe07AQBxg6uFTUwZIB5cQ
         jDLv6gFYA01yyocGVKhCzzl662QwDOFJfc0JSOByck06+rZeIV5/tnD3FJhXPdkgRt8s
         EYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=t05Th32JwFDrspvfCaVps5qrLbDP0ziOmcXOCj+YI1c=;
        b=R8ruiXRXUu+lpQY3CiPfeVUcwMymWhQg4QwqeIrrE2ZobfrML+ku8AhPogQEjgGiYP
         DoNvzDSU6B4pEL1r15XDWQOIliQeieUbtjnqvDAz2ndPE+I3XAmoWCZv7m6vbp290zks
         TMrJ7Hlh7F/fU6m0awZZ7WSf/lEnSkpovUPsTObhA4UlQPuTCkBGY0PTw+Mm6H8z/x/w
         vDRh4R2ut2acn2sDhln/D4mJc5Xu1EkKvGXbH3r/8vxyEtpY8kPAf7upImHQ2J99uFBL
         xVpqfjmoZDg6vWg5ftt2wGg2iqbiY8vhtUWB0s2/nDjfrNe/i7YsEPvCbcsDivetlEaF
         iFJw==
X-Gm-Message-State: AOAM533rIRUGDXs+fFYpWyS84R5sJHq2O1K1sn+tqJQ18ZY/zT9EgXxP
        bG2zaKVWjA8js399OJK4kUVgx7ElkokwsSUj
X-Google-Smtp-Source: ABdhPJyL05WI+j4IktJzVYTnog/rwnAH3sVPkcM+bD/hYlkNZ9jNT1Im0yNBjJJS3zyQCWcJBHeHrw==
X-Received: by 2002:a05:6602:1541:b0:649:94e:3cf7 with SMTP id h1-20020a056602154100b00649094e3cf7mr12679902iow.10.1647959468866;
        Tue, 22 Mar 2022 07:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b1-20020a926701000000b002c25d28d378sm10625894ilc.71.2022.03.22.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:31:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kbusch@kernel.org, linux-block@vger.kernel.org
Cc:     ebiggers@kernel.org
In-Reply-To: <20220322142107.4581-1-kbusch@kernel.org>
References: <20220322142107.4581-1-kbusch@kernel.org>
Subject: Re: [PATCH] crytpo: fix crc64 testmgr digest byte order
Message-Id: <164795946811.117115.14257315669178285596.b4-ty@kernel.dk>
Date:   Tue, 22 Mar 2022 08:31:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Mar 2022 08:21:07 -0600, kbusch@kernel.org wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The result is set in little endian, so the expected digest needs to
> be consistent for big endian machines.
> 
> 

Applied, thanks!

[1/1] crytpo: fix crc64 testmgr digest byte order
      commit: c30cf83999ad58135fa01fbf9f2b15ce15b5cc4a

Best regards,
-- 
Jens Axboe



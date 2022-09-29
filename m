Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1888DC433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiI2S4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiI2S4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 14:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F221145C95
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 11:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0481B825A3
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D0C433C1;
        Thu, 29 Sep 2022 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664477793;
        bh=hOQQv7VOlaYsgaMDOtt7wdfKpZzYcGIEQozcBJ0GMaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKbFpwJD9tSzzsgei5Bjpb/Homwc/r5q/GzBoIw095obUSWPhjWfnTgvGLsIQv39r
         OcRWeRkeycoqhccbyYnEcmAFB3UO0B1TozICX9jwxy50NJBTQnwLBp/3Il02YPRZHE
         641TYmdoLfn5XL/Rz8W+LprXDtFbir6yzdKY+a+JVivtPyTz4IRVSoQExXTtatVTVn
         T+oeZC4K8Dtp/rER6jBqBjrWx+6Q/TMHKa+sry9/0PNJC9XmUr/8iqoQYE1epiD7Y1
         isHtwJ5SxmPPNsQEMNczahXtXQkvZKpswb/prWx4sSD6IC5fTPITjUj18eOdH02HmG
         UCGF3MZbKQaFw==
Date:   Thu, 29 Sep 2022 12:56:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme: use macro definitions for setting reservation
 values
Message-ID: <YzXqXhQaV82ZWyEb@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929115919.9906-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929115919.9906-1-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 02:59:19PM +0300, Max Gurtovoy wrote:
> +/*
> + * Reservation Type Encoding
> + */
> +enum {
> +	NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - Registrants Only Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - Registrants Only Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All Registrants Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All Registrants Reservation */
> +};

The comments are unnecessary, and this would be more readable if the values
were tab aligned like 'enum pr_type'.

Otherwise looks good.

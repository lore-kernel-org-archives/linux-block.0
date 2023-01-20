Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B960C05027
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 07:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjATHY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 02:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjATHYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 02:24:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABE79EA1;
        Thu, 19 Jan 2023 23:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B38EB82070;
        Fri, 20 Jan 2023 07:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F5C433D2;
        Fri, 20 Jan 2023 07:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199480;
        bh=iEItLwJPP/H/zv4w3aiF/drDpfal7Gc38LwVopyoWtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bvzgc24Ei13L+Pd2Zhnv+pmBmeBp9R56pJThBjE+ICCf/ugW8ZRHhut0VI/n6loTN
         kQfloXVr9t3qA8OBmW43P6bLsSmBP70UUcu6YaOUEPSdBg8QK9kDpWU5dhGpsT3Gvm
         Isf7eK0vLkhWXAAhe36AnE9fWanRqqVOS7ZRtg6M=
Date:   Fri, 20 Jan 2023 08:24:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] pktcdvd: Get rid of custom printing macros
Message-ID: <Y8pBtF6BbPjkuAxQ@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:01AM +0200, Andy Shevchenko wrote:
> We may use traditional dev_*() macros instead of custom ones
> provided by the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

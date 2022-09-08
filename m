Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CAC54EE9
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 11:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiIHLtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiIHLts (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 07:49:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5112D1B;
        Thu,  8 Sep 2022 04:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3D1FB820D2;
        Thu,  8 Sep 2022 11:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF07C433C1;
        Thu,  8 Sep 2022 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662637782;
        bh=g4qAFqq0hkSEXU7h41NwOrSRebV9g97WbblautAhiGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvlluBFgH6xIjm3hHG8D1G1s3TD1tETbo6RehWyIp5CurslvAK3zSZSQj2VMFgsb+
         cZ+kO+ytLc0o6rN57jAmkto7PHUoxc4p3YCxH8sw4SBnPqzwtABiRu4Qa47mr4c7AZ
         SGNgc85z35csPsyuu3zfWjSsddZHWGnJWCqmdMDk=
Date:   Thu, 8 Sep 2022 13:50:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH for-stable-5.10.y] xen-blkfront: Cache feature_persistent
 value before advertisement
Message-ID: <YxnW7P7TYBu4ZCXS@kroah.com>
References: <20220906162414.105452-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906162414.105452-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 06, 2022 at 04:24:14PM +0000, SeongJae Park wrote:
> commit fe8f65b018effbf473f53af3538d0c1878b8b329 upstream.
> 
> Xen blkfront advertises its support of the persistent grants feature
> when it first setting up and when resuming in 'talk_to_blkback()'.
> Then, blkback reads the advertised value when it connects with blkfront
> and decides if it will use the persistent grants feature or not, and
> advertises its decision to blkfront.  Blkfront reads the blkback's
> decision and it also makes the decision for the use of the feature.
> 
> Commit 402c43ea6b34 ("xen-blkfront: Apply 'feature_persistent' parameter
> when connect"), however, made the blkfront's read of the parameter for
> disabling the advertisement, namely 'feature_persistent', to be done
> when it negotiate, not when advertise.  Therefore blkfront advertises
> without reading the parameter.  As the field for caching the parameter
> value is zero-initialized, it always advertises as the feature is
> disabled, so that the persistent grants feature becomes always disabled.
> 
> This commit fixes the issue by making the blkfront does parmeter caching
> just before the advertisement.
> 
> Fixes: 402c43ea6b34 ("xen-blkfront: Apply 'feature_persistent' parameter when connect")
> Cc: <stable@vger.kernel.org> # 5.10.x
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Link: https://lore.kernel.org/r/20220831165824.94815-4-sj@kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> 
> This patch is a manual backport of the upstream commit on the 5.10.y
> kernel.  Please note that this patch can be applied on the latest 5.10.y
> only after the preceding patch[1] is applied.
> 
> [1] https://lore.kernel.org/stable/20220906132819.016040100@linuxfoundation.org/

Now queued up, thanks.

greg k-h

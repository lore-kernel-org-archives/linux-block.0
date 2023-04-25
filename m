Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1850C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjDYNix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjDYNiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 09:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CBFF
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 06:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C2962534
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 13:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40142C433EF;
        Tue, 25 Apr 2023 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682429930;
        bh=n5wEodSDS1fsScLM3fwMTWWhf9vKTFG8fbF0I5rZvLE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S6LnAOZs+24E099OStgxIjzhlMiYc6NxmnxM6F1B3KbRMyvwkvikoZGeNd/O9/LaK
         sSFzqnNApbOtZ+ADnhFMa5Gu6hZy5hI2hW2//yVq3VMn+2VVKkhy6hs0Cbkpnr2Wss
         n6bDqlIbNYDqT6McmCORSS4b9k5co5s64FJ4kJSuKC6DGb/abpr9WU6ntldeQq9E7Z
         Q2z22a04j2gMecy2GiQ1tMVRLssKLEY2vx1EVmZtkpYgT9QzkwLHjdljtgIVWYWUva
         0kpcy9ofkv+4bkVcV3uNhj4pqSmSZ7oYSe7p7LztwgyhZ+n8WB/afW596mOhMnUALv
         XB2JDRQ52q55w==
Message-ID: <9e1a1dab-77c3-77c1-b71b-0385a15a599e@kernel.org>
Date:   Tue, 25 Apr 2023 22:38:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
 <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
 <ZEHY2PIRCCLOZsC4@google.com>
 <c12582e0-f2c8-d001-1fc1-6f7e17eeba7c@kernel.org>
 <ZELu0yKwnGg3iBmA@google.com>
 <335b63b0-5a9e-472d-2cce-c0158ae93cf3@kernel.org>
 <20230424060139.GA9805@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230424060139.GA9805@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/23 15:01, Christoph Hellwig wrote:
> On Sat, Apr 22, 2023 at 07:25:33AM +0900, Damien Le Moal wrote:
>>>> for allocating blocks. This is a resource management issue.
>>>
>>> Ok, so it seems I overlooked there might be something in the zone allocation
>>> policy. So, f2fs already manages 6 open zones by design.
>>
>> Yes, so as long as the device allows for at least 6 active zones, there are no
>> issues with f2fs.
> 
> I don't think it's quite as rosy, because f2fs can still schedule
> I/O to the old zone after already scheduling I/O to a new zone for
> any of these 6 slots.  It'll need code to wait for all I/O to the old
> zone to finish first, similar to btrfs.

Indeed. Good point.


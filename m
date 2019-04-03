Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF3C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622F32084C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308240;
	bh=4ad0WdrRQyGOKRnAcVv+KyQJGoUhZqOCasLbvMBNySk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GHETuVgco4zR0T8GUek4Wjx7b97P7E9RZ2bDibHmYNdxR7MY9+dxvlOnRrTzpWCdR
	 5qOKTZAzK5gQcl3DKv5OJpnnux05fOD1IYkDxrkdAaAydc9NM+MLFune7hNlxKahgS
	 143hxHFFYI2Z79cqPUSxqsTmgtZWd1j25p2PTApc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCQRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCQRT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 12:17:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E264206B7;
        Wed,  3 Apr 2019 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308238;
        bh=4ad0WdrRQyGOKRnAcVv+KyQJGoUhZqOCasLbvMBNySk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+6m66Abh1YW2NLO9TCl+cPkHitFByGYD1kOWqY9cl5X46kalcGvHF2mo44X4FeOO
         m667JdtdeSlsTwat++bXKNVGWXxnt89PE8F9MCm3FY7awUR3qbfIuRTOsWipefd1dm
         KzFL6Y4CwJRDZZCBftk2JB+WYL/SHG6LtQlbm88I=
Date:   Wed, 3 Apr 2019 12:17:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 33/57] blk-mq: protect
 debugfs_create_files() from failures
Message-ID: <20190403161717.GC16241@sasha-vm>
References: <20190330012854.32212-1-sashal@kernel.org>
 <20190330012854.32212-33-sashal@kernel.org>
 <20190330054311.GA23655@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190330054311.GA23655@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 30, 2019 at 06:43:11AM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 29, 2019 at 09:28:26PM -0400, Sasha Levin wrote:
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> [ Upstream commit 36991ca68db9dd43bac7f3519f080ee3939263ef ]
>>
>> If debugfs were to return a non-NULL error for a debugfs call, using
>> that pointer later in debugfs_create_files() would crash.
>>
>> Fix that by properly checking the pointer before referencing it.
>>
>> Reported-by: Michal Hocko <mhocko@kernel.org>
>> Reported-and-tested-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
>> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  block/blk-mq-debugfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index cb1e6cf7ac48..9dc3a0896462 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -806,6 +806,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>>  static bool debugfs_create_files(struct dentry *parent, void *data,
>>  				 const struct blk_mq_debugfs_attr *attr)
>>  {
>> +	if (IS_ERR_OR_NULL(parent))
>> +		return false;
>> +
>>  	d_inode(parent)->i_private = data;
>>
>>  	for (; attr->name; attr++) {
>> --
>> 2.19.1
>>
>
>This was a 5.0-only thing, no need for it to be backported anywhere.
>Please drop it from all of your trees.

Dropped, thanks.

--
Thanks,
Sasha

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DBC678DB
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 07:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCGHCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 02:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCGHCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 02:02:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9AA8B324
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 23:01:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DD291F8B2;
        Tue,  7 Mar 2023 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678172176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXnneGKjUrL6W8YJ3E1WRs8EActWtffnzXlOzW+GUmM=;
        b=fI3t5Qggy9m5v8tjUxm6GbG7XPZuXAQXcSUDTtqc9ogOD9+PUiyIS0z3Yg+EA/O/2Iqpcg
        QL/eQZRgSztr9iOlGpU5TT0/Y03ufsOfK8MpeFfoLmUkOZtlrmonm9EmbqjZ8W7TJS0Pif
        W4jAreKtjTwkmQQf0HGz4OXuH0jK5t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678172176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXnneGKjUrL6W8YJ3E1WRs8EActWtffnzXlOzW+GUmM=;
        b=ngkwoMzlrD1qld+UHOGP6/+vN6zKTLHaKUXrbntI5GbuizfHUUAH0DT9iTvJ0SsuNtgpcp
        Xvw0vF20Zaen0yCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F20B13440;
        Tue,  7 Mar 2023 06:56:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wjV7FhDgBmQsZAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Mar 2023 06:56:16 +0000
Message-ID: <a0292dba-9e9b-e2f5-dfd9-7865c9e208c8@suse.de>
Date:   Tue, 7 Mar 2023 07:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] brd: limit maximal block size to 32M
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-5-hare@suse.de> <ZAYldLT52jAc82Xj@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAYldLT52jAc82Xj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/23 18:40, Matthew Wilcox wrote:
> On Mon, Mar 06, 2023 at 01:01:26PM +0100, Hannes Reinecke wrote:
>> Use an arbitrary limit of 32M for the maximal blocksize so as not
>> to overflow the page cache.
> 
> The page allocator tops out at MAX_ORDER (generally 4MB), so that might
> be a better limit.  Also, this has nothing to do with the page cache,
> right?

Indeed. Sloppy description.
Will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


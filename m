Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4369C7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 09:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjDEJkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjDEJkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 05:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2431A8
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680687592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6/gndAOrjzqgdvU+zeWHqeqrh04xdg9YQciJAmQi7Y=;
        b=etucFVyKLi882tknc4bkXEyfm7P7d9kzqBXE3GSYyCfqfL+A6sng/aXEqXxktmBZeuCPzY
        sO9Tx6jMmbxbyFW2S3KVPpybu/RX4urzT+cjjYCAIkGawM/N/Fuo2HI+31ytdBb0J/upji
        nvc/A9bs89lKkjW7Wg3L5ELpfGLLUd0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-_5q3T1QeMZqfdWNLRrYouQ-1; Wed, 05 Apr 2023 05:39:51 -0400
X-MC-Unique: _5q3T1QeMZqfdWNLRrYouQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5004f5f7279so178859a12.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 02:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687590;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6/gndAOrjzqgdvU+zeWHqeqrh04xdg9YQciJAmQi7Y=;
        b=7r+HuNpe/L/Z1bEpgLn1+EATKr0vnYDA0Pq4RPQ4KDttCLCkdMdNSRON24LwED7XwV
         +hl0xogPAdftHnyfPg4tpLu2T5/1+c4Ml3kAbW3XlKvGX8Btmp+Gh5iLEjEJaLqM+WNJ
         gsDFIHuAdomEWEVleff7OL/ydrgCIQulCnT6dXXG8lnlS65PX8FNhLg+ydficbs5gXW2
         H/0RZ5p014rArpG95aSJU1qySpCFUK/8cAqNjcBHhEAnhHtdlVAJ/qj0vAvdgULYVicq
         jolA2vk2YB1KiMNhxIvdKQXJ1fWVUdontt0C9dvKwWv8wsFhkvMLGXdMVJlhym1KcTkV
         mjHA==
X-Gm-Message-State: AAQBX9ex/XA4zNja93UUMKeL8Ij7j6AUQnzwdKR2PYdFOngXbLz9csdb
        fiKpZiN5dInNx1p4Ghv00pEAEBW6TRKvdhX1ZaAvsIRvJk60Mh/+QW5jgjp6PyT+BdRhgfTXtQo
        DNFG+WtzeYvaHMfK0JlSikQ==
X-Received: by 2002:a50:fb0e:0:b0:4fa:a1a1:9e14 with SMTP id d14-20020a50fb0e000000b004faa1a19e14mr1221337edq.30.1680687590246;
        Wed, 05 Apr 2023 02:39:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZBSAMZKXXBZhUlyUh5ZBdqz5kfmR1dPsUfhtBXMbANEdE9Hk4BTE2VrBvSgoQ1vf0QAr0XJg==
X-Received: by 2002:a50:fb0e:0:b0:4fa:a1a1:9e14 with SMTP id d14-20020a50fb0e000000b004faa1a19e14mr1221322edq.30.1680687589939;
        Wed, 05 Apr 2023 02:39:49 -0700 (PDT)
Received: from [10.43.17.42] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g29-20020a50d0dd000000b004c0239e41d8sm7066481edf.81.2023.04.05.02.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:39:49 -0700 (PDT)
Message-ID: <36d11bf6-a0c9-b02f-020c-df25d06c7aee@redhat.com>
Date:   Wed, 5 Apr 2023 11:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, jonathan.derrick@linux.dev
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-6-okozina@redhat.com>
 <20230405-komitee-treten-36f2c0a823b6@brauner>
Content-Language: en-US
From:   Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH 5/5] sed-opal: Add command to read locking range
 parameters.
In-Reply-To: <20230405-komitee-treten-36f2c0a823b6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05. 04. 23 10:27, Christian Brauner wrote:
> On Wed, Mar 22, 2023 at 04:16:04PM +0100, Ondrej Kozina wrote:
>> +	if (!response_token_matches(tok, OPAL_STARTNAME)) {
>> +		pr_debug("Unexpected response token type %d.\n", n);
>> +		return OPAL_INVAL_PARAM;
>> +	}
>> +
>> +	if (response_get_u64(resp, ++n) != column) {
> 
> Please don't rely on side-effects and increment explicitly before or
> after the functin call so ++n and n++ doesn't matter.

Going to fix in version 2.

> 
>> +		pr_debug("Token %d does not match expected column %u.\n", n, column);
>> +		return OPAL_INVAL_PARAM;
>> +	}
>> +
>> +	val = response_get_u64(resp, ++n);
>> +
>> +	tok = response_get_token(resp, ++n);
>> +	if (IS_ERR(tok))
>> +		return PTR_ERR(tok);
>> +
>> +	if (!response_token_matches(tok, OPAL_ENDNAME)) {
>> +		pr_debug("Unexpected response token type %d.\n", n);
>> +		return OPAL_INVAL_PARAM;
>> +	}
>> +
>> +	*value = val;
>> +	*iter = ++n;
> 
> This is how they explain side-effects in textbooks. :)

Ditto.

(...)
>> +
>> +	/* skip session info when copying back to uspace */
>> +	if (!ret && copy_to_user(data + offsetof(struct opal_lr_status, range_start),
>> +				(void *)opal_lrst + offsetof(struct opal_lr_status, range_start),
> 
> Better written as
> 
> (void *)(opal_lrst + offsetof(struct opal_lr_status, range_start))

Nack. I need to read bytes from offset _inside_ struct opal_lr_status. 
This change would actually read from memory beyond pointed to by 
opal_lrst pointer.

(...)
>> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
>> index d7a1524023db..3905c8ffedbf 100644
>> --- a/include/uapi/linux/sed-opal.h
>> +++ b/include/uapi/linux/sed-opal.h
>> @@ -78,6 +78,16 @@ struct opal_user_lr_setup {
>>   	struct opal_session_info session;
>>   };
>>   
>> +struct opal_lr_status {
>> +	struct opal_session_info session;
>> +	__u64 range_start;
>> +	__u64 range_length;
>> +	__u32 RLE; /* Read Lock enabled */
>> +	__u32 WLE; /* Write Lock Enabled */
> 
> Why is that in capital letters if I may ask? That seems strange uapi for
> Linux. And why not just "read_lock_enabled" and "write_lock_enabled"
> given that we also have "range_start" and "range_length". Let's not
> CREAT one of those weird uapis if we don't have to.

See 'opal_user_lr_setup' struct above. Since the new command is supposed 
to return those parameters I did not want to add confusion by naming it 
differently.

> 
>> +	__u32 l_state;
> 
> "locking_state"?

Same as above, see 'opal_lock_unlock' struct. It's even spicier 
considering it's impossible to set WRITE_ONLY state (lock only read I/O)
with sed-opal iface.


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E259BC77B75
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEDDSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEDDSb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:18:31 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1E10D9
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 20:18:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QBfCf4NQwz4f3l7M
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 11:18:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbH+I1NkNardIg--.56157S3;
        Thu, 04 May 2023 11:18:24 +0800 (CST)
Subject: Re: [PATCH blktests v2] tests/dm: add a regression test
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     "shinichiro@fastmail.com" <shinichiro@fastmail.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230427024126.1417646-1-yukuai1@huaweicloud.com>
 <2lsxdy3n7vfwtmyubfc7kh7yd6mxrht6nlnhmvwzrsellij3kc@5hctf5lvmr6e>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7cbad327-d0aa-cbd9-0dc9-c30cd19a8df2@huaweicloud.com>
Date:   Thu, 4 May 2023 11:18:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2lsxdy3n7vfwtmyubfc7kh7yd6mxrht6nlnhmvwzrsellij3kc@5hctf5lvmr6e>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbH+I1NkNardIg--.56157S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrykWr4UWr15Jw4kZw18Xwb_yoW8JFWUp3
        98tFnIyrZ5Ca47K3Wxuw40va4rJF43Crn8Ar17Wr18A3s8X3WrXasIkF13Za4rZFZ8XFn3
        Za4Fqr93uw4jv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/05/01 12:34, Shinichiro Kawasaki Ð´µÀ:
> Yu, thanks for the patch. I have three minor comments below. Other than that,
> the patch looks good to me. If you do not mind, I can do these edits. Please let
> me know your thoughts.

I'm good with your comments.

Thanks,
Kuai
> 
> 1) Let's describe a bit more in the commit title, like,
>     "tests/dm: add dm test group and a test for self-map"
> 2) From historical reason, we add executable mode to the test script files.
>     Let's add the file mode 755 to the tests/dm/001 file.
> 3) Please run "make check" to find script issues. With the command, shellcheck
>     reports a warning:
> 
>     tests/dm/001:23:7: note: Check exit code directly with e.g. 'if mycmd;', not indirectly
>     with $?. [SC2181]
> 
> A hunk below will avoid the warning.
> 
> diff --git a/tests/dm/001 b/tests/dm/001
> index 09731d8..f69f30f 100644
> --- a/tests/dm/001
> +++ b/tests/dm/001
> @@ -19,8 +19,8 @@ test_device() {
>   
>   	dmsetup create test --table "0 8192 linear ${TEST_DEV} 0"
>   	dmsetup suspend test
> -	dmsetup reload test --table "0 8192 linear /dev/mapper/test 0" &> /dev/null
> -	if [ $? -eq 0 ]; then
> +	if dmsetup reload test --table "0 8192 linear /dev/mapper/test 0" \
> +	   &> /dev/null; then
>   		echo "reload a dm with maps to itself succeed."
>   	fi
>   	dmsetup remove test
> 
> .
> 


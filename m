Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C51FCFD3
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093694; cv=none; b=l8MBi6cUUcVgOCvsLfjSvDy7dPA9SHk9e1YwRye0Z5IIFT7zyY/iwhZrHvpVEowt/f9gnGZk2uxDg92Xbz1tBNmMrJ2q9oispkXDx2Qu5cfyqCJDWD/hpG170BLZQU4nQJI9HQHf01/sGZ9jwFf0HhYBrmYHCYF46QEyAPWRgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093694; c=relaxed/simple;
	bh=o+18Gvk6i5ZAdBjUO5UE/Ocyl2SDouZB22Xh9ZdhxWc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QKqRL5pVyz2X2JcyP8lUMtWzAdo+KMR3xyz4luIL80Ljlnl/xydXfUddZu0Zwcy7b5zfeDJ2rFAphJZEtOk7+VUVlPZmkztlI07xkdCv5GP0AJ8CchGnehUlCYkNAHU11lLqjpSdu2nP+S1WlR7HojXWs6NkrsVPDSsajGp/JLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z6bZS4v2yz4f3jYG
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 21:07:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C265A1A1947
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 21:08:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l41+8ZnwcoYFg--.45068S3;
	Tue, 04 Mar 2025 21:08:06 +0800 (CST)
Subject: Re: [PATCH] tests/throtl: add a new test 006
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
 <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
 <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
 <d0013f94-65a0-684f-6122-d8e98eb3e9bf@huaweicloud.com>
 <7ff7166f-3069-59ae-6820-98e8b76057d6@huaweicloud.com>
 <Z8bPm44sMy88l0yL@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5ae724a4-966a-3276-f9f7-ed720dc524be@huaweicloud.com>
Date: Tue, 4 Mar 2025 21:08:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8bPm44sMy88l0yL@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l41+8ZnwcoYFg--.45068S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3tw4kXr4UWw4UXF4kXrb_yoWDXFgEgF
	yxKFZ2kFyUZ3W2yr4kKFWkurZxKF4ruFyIga4rXFyfKrn8uF18GFZrKry5Zr9rZ3WYq39F
	kryYvF4kGw1fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/03/04 18:02, Ming Lei 写道:
> But the issue still can't be reproduced by adding the following delta
> change, meantime revert 29390bb5661d ("blk-throttle: support prioritized
> processing of metadata") on kernel side.

Because you're issuing 64 64k IO, and dd is issuing next IO after the
previous IO is done.

Following diff will work for this test:

Thanks,
Kuai

diff --git a/tests/throtl/006 b/tests/throtl/006
index 4baadaf..758293b 100755
--- a/tests/throtl/006
+++ b/tests/throtl/006
@@ -43,8 +43,13 @@ test() {

         _throtl_set_limits wbps=$((1024 * 1024))
         {
+               local jbd2_pid
+
+               jbd2_pid=$(ps -eo pid,comm |grep "jbd2/${THROTL_DEV}" 
|awk '{print $1}')
                 echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-               _throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 64K 64 &
+               echo "$jbd2_pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+
+               _throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 4M 1 &
                 sleep 2
                 test_meta_io "${TMPDIR}/mnt"
                 wait


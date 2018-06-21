Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAAM7YAko88Bq0Nbh4EcYifEcnzHTJ500YvofWA-uMxrwqANzpA@mail.gmail.com>
References: <20180620155101.57685-1-arnd@arndb.de> <20180620155101.57685-4-arnd@arndb.de>
 <CAAM7YAko88Bq0Nbh4EcYifEcnzHTJ500YvofWA-uMxrwqANzpA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 Jun 2018 16:57:16 +0200
Message-ID: <CAK8P3a2sq8_S94n8KczWTL6ZGJvR7Zw3bP2Cihyr5bmxFTjCQg@mail.gmail.com>
Subject: Re: [PATCH 4/5] ceph: use timespec64 for r_mtime
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Alex Elder <elder@kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>,
	ceph-devel <ceph-devel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	David Miller <davem@davemloft.net>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Dillaman <dillaman@redhat.com>, daniel.m.jordan@oracle.com, Jan Kara <jack@suse.cz>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 21, 2018 at 2:41 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:

>> @@ -1013,7 +1013,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>>                         truncate_inode_pages_range(inode->i_mapping, pos,
>>                                         (pos+len) | (PAGE_SIZE - 1));
>>
>> -                       req->r_mtime = mtime;
>> +                       req->r_mtime = current_time(inode);
> this change is not needed

Good catch, no idea how those two changes ended up in here, I'll
resend without them.

Thanks,

      Arnd

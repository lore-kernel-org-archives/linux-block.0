Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/11] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-6-git-send-email-axboe@kernel.dk>
 <20170619062800.GD2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7bfc17a0-2aeb-fc85-ffb7-53a4315925dd@kernel.dk>
Date: Mon, 19 Jun 2017 08:57:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170619062800.GD2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:28 AM, Christoph Hellwig wrote:
> On Sat, Jun 17, 2017 at 01:59:48PM -0600, Jens Axboe wrote:
>> We have a pwritev2(2) interface based on passing in flags. Add an
>> fcntl interface for querying these flags, and also for setting them
>> as well:
>>
>> F_GET_RW_HINT		Returns the read/write hint set. Right now it
>> 			will be one of the WRITE_LIFE_* values.
>>
>> F_SET_RW_HINT		Pass in rw_hint type to set the read/write hint.
>> 			Only WRITE_LIFE_* hints are currently supported.
>> 			Returns 0 on succes, -1 otherwise.
>>
>> Sample program testing/implementing basic setting/getting of write
>> hints is below.
>>
>> /*
>>  * writehint.c: check or set a file/inode write hint
>>  */
>>
>> static char *str[] = { "WRITE_LIFE_NONE", "WRITE_LIFE_SHORT",
>> 			"WRITE_LIFE_MEDIUM", "WRITE_LIFE_LONG",
>> 			"WRITE_LIFE_EXTREME" };
>>
>> int main(int argc, char *argv[])
>> {
>> 	int hint = -1, fd, ret;
>>
>> 	if (argc < 2) {
>> 		fprintf(stderr, "%s: dev <hint>\n", argv[0]);
>> 		return 1;
>> 	}
>>
>> 	fd = open(argv[1], O_RDONLY);
>> 	if (fd < 0) {
>> 		perror("open");
>> 		return 2;
>> 	}
>>
>> 	if (argc > 2)
>> 		hint = atoi(argv[2]);
>>
>> 	if (hint == -1) {
>> 		ret = fcntl(fd, F_GET_RW_HINT);
>> 		if (ret < 0) {
>> 			perror("fcntl: F_GET_RW_HINT");
>> 			return 3;
>> 		}
>> 		hint = ret;
>> 	} else {
>> 		ret = fcntl(fd, F_SET_RW_HINT, hint);
>> 		if (ret < 0) {
>> 			perror("fcntl: F_SET_RW_HINT");
>> 			return 4;
>> 		}
>> 	}
>>
>> 	printf("%s: %shint %s\n", argv[1], hint != -1 ? "set " : "", str[hint]);
>> 	close(fd);
>> 	return 0;
>> }
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/fcntl.c                 | 38 ++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fcntl.h |  6 ++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index f4e7267d117f..417ce336c875 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -243,6 +243,40 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
>>  }
>>  #endif
>>  
>> +long fcntl_rw_hint(struct file *file, unsigned int cmd, unsigned long arg)
> 
> The unsigned long arg is a little annoying because it will de different
> size for 32-bit vs 64-vit architectures.
> 
> How about just doing a get_user and use a fixed-size 64-bit value?

It's just passing it in from fcnt(), my intent was for it to be a u32 on the
uapi side. But we can make it a 64-bit type, since we're going away from
the enum and making it a proper type.

-- 
Jens Axboe
